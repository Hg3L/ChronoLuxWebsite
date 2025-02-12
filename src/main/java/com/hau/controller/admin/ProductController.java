package com.hau.controller.admin;

import com.hau.dto.*;
import com.hau.entity.CommentEntity;
import com.hau.service.*;
import com.hau.util.CartUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialBlob;
import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;

@Controller
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private BrandService brandService;
    @Autowired
    private FileService fileService;
    @Autowired
    private ProductLineService productLineService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private UserService userService;
    private static final String UPLOAD_DIR = "products";
    @PostMapping("/comment")
    public String addComment(@ModelAttribute CommentDTO commentDTO , @RequestParam("img") MultipartFile multipartFile) throws IOException, SQLException {
        commentDTO.setImgReviewUrl(new SerialBlob(multipartFile.getBytes()));
        commentService.save(commentDTO);
        return "redirect:/product-detail?id="+commentDTO.getProductId();
    }
    @GetMapping("/comment/image/{id}")
    public void getProductImage(@PathVariable("id") Long id, HttpServletResponse response) throws IOException, SQLException {
        Blob image = commentService.findById(id).getImgReviewUrl();
        byte[] imageData = image.getBytes (1, (int) image.length());

        if (imageData != null) {
            response.setContentType("image/webp");
            response.getOutputStream().write(imageData);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // Không có ảnh
        }
    }
    @GetMapping(value = "/product-detail")
    public String productDetailPage(Model model, @RequestParam("id") long id
            , @AuthenticationPrincipal Authentication authentication) {

        ProductDTO product = productService.findByIdAndActive(id,true);
        try{
            List<CommentDTO> commentEntities = commentService.findByProductId(id);
            model.addAttribute("commentList",commentEntities);
            model.addAttribute("totalComment",commentEntities.size());
        }catch (RuntimeException ignored){

        }

        if(authentication != null){
            UserDTO userDTO = userService.getCurrentLoggedInCustomer(authentication);
            model.addAttribute("user",userDTO);
        }

        model.addAttribute("model",product);


        model.addAttribute("productByBrands",productService.findAllByIdBrandNotPage( product.getBrandId()));
        return "web/product-detail";
    }

    @GetMapping("/admin/products")
    public String showProducts(@RequestParam(defaultValue = "1") int page,
                               @RequestParam(defaultValue = "6") int limit,
                               @RequestParam(defaultValue = "0") Long brandId,
                               @RequestParam(defaultValue = "0") Long productLineId,
                               Model model) {
        Page<ProductDTO> productDTOPage;
        if((brandId == 0 && productLineId == 0) || (brandId == 0 && productLineId == -1)){
            productDTOPage = productService.findAll(page, limit);
        }
        else if(brandId != 0 && productLineId == null){
            productDTOPage = null;
        }
        else if(brandId != 0 && productLineId == 0){
            productDTOPage = productService.findByBrand_Id(brandId, page, limit);
        }
        else{
            productDTOPage = productService.findByProductLine_Id(productLineId, page, limit);
        }
        model.addAttribute("brands", brandService.findAllByActive(true));
        model.addAttribute("productPage", productDTOPage);
        model.addAttribute("productLineId", productLineId);
        model.addAttribute("brandId", brandId);
        model.addAttribute("currentPage", page);
        return "admin/product-view";
    }

    @GetMapping("/admin/product/create")
    public String createProduct(Model model,
                                @RequestParam("currentPage") int page) {
        model.addAttribute("product", new ProductDTO());
        model.addAttribute("brands", brandService.findAllByActive(true));
        model.addAttribute("currentPage", page);
        return "admin/product-add";
    }

    @PostMapping("/admin/product/save")
    public String saveProduct(@ModelAttribute("product") ProductDTO productDTO,
                              @RequestParam("img") MultipartFile img,
                              @RequestParam("page") int currentPage,
                              HttpServletRequest request,
                              RedirectAttributes redirectAttributes) throws Exception {
        request.setCharacterEncoding("UTF-8");
        if(!img.isEmpty()) {
            String imgName = fileService.saveFile(img, UPLOAD_DIR);
            productDTO.setImgUrl(imgName);
        }
        else{
            ProductDTO product = productService.findByIdAndActive(productDTO.getId(),true);
            productDTO.setImgUrl(product.getImgUrl());
        }
        productService.save(productDTO);
        String message = (productDTO.getId() == null || productDTO.getId() == 0) ? "Thêm sản phẩm thành công" : "Cập nhật sản phẩm thành công";
        redirectAttributes.addFlashAttribute("successMessage", message);
        return "redirect:/admin/products?page=" + currentPage;
    }

    @GetMapping("/admin/product/update")
    public String updateProduct(Model model,
                                @RequestParam("id") long id,
                                @RequestParam("currentPage") int page) {
        ProductDTO product = productService.findByIdAndActive(id,true);
        model.addAttribute("product", product);
        model.addAttribute("brands", brandService.findAllByActive(true));
        model.addAttribute("currentPage", page);
        return "admin/product-update";
    }

    @GetMapping("/admin/product/delete")
    public String deleteProduct(@RequestParam("id") long id, HttpServletRequest request, HttpServletResponse response) {
        String txt = "";
        CartDTO cartDTO = CartUtils.getCartByCookieAndDeleteCookie(request.getCookies(),productService.findAllByActive(true),txt,response);
        cartDTO.getCartItemDTOS().removeIf(cartItem ->  cartItem.getProductId() == id);
        List<CartItemDTO> items = cartDTO.getCartItemDTOS();
        txt = "";
        if(items.size()>0){
            txt = items.get(0).getUsername()+":"+items.get(0).getProductId()+":"+ items.get(0).getQuantity();
            for(int i = 1 ; i<items.size(); i++) {
                txt += "|" +items.get(i).getUsername() +":"+items.get(i).getProductId() +":"+ items.get(i).getQuantity();
            }
        }
        Cookie c  = new Cookie("cart",txt);
        c.setMaxAge(2*24*60*60);
        c.setPath("/ChronoLuxWeb");
        response.addCookie(c);

        productService.delete(id);


        return "redirect:/admin/products";



    }
}
