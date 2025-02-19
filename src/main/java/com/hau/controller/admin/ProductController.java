package com.hau.controller.admin;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.NestedServletException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialBlob;
import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
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
    @Autowired
    private RestTemplate restTemplate;
    private static final String UPLOAD_DIR = "products";
    @PostMapping("/comment")
    public String addComment(@ModelAttribute CommentDTO commentDTO , @RequestParam("img") MultipartFile multipartFile) throws IOException, SQLException {
        commentDTO.setImgReviewUrl(new SerialBlob(multipartFile.getBytes()));
        commentService.save(commentDTO);

        return "redirect:/product-detail?id="+commentDTO.getProductId();
    }
    @GetMapping("/api/getProduct")
    @ResponseBody
    public String getProduct(@RequestParam("id") Long id) {
        String apiUrl = "http://localhost:5555/api?id=" + id;
        return restTemplate.getForObject(apiUrl, String.class); // Trả về JSON từ API
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
            , @AuthenticationPrincipal Authentication authentication) throws IOException {

        ProductDTO product = productService.findByIdAndActive(id,true);
        Double rating = commentService.calculateAverageRating(id);
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
        List<ProductDTO> productSuggestions = new ArrayList<>();
        try{
            String apiUrl = "http://localhost:5555/api?id=" + id;
            String response =  restTemplate.getForObject(apiUrl, String.class);
            // Tạo ObjectMapper để xử lý JSON
            ObjectMapper objectMapper = new ObjectMapper();

            // Đọc JSON thành JsonNode
            JsonNode jsonNode = objectMapper.readTree(response);

            // Lấy danh sách sản phẩm từ JSON
            List<String> productSuggestionsApi = Arrays.asList(objectMapper.convertValue(jsonNode.get("san pham goi y: "), String[].class));

            productSuggestionsApi.forEach(productSuggestion ->{
                ProductDTO productDTO= productService.findByName(productSuggestion);
                productSuggestions.add(productDTO);
            } );
            model.addAttribute("productByBrands",productSuggestions);
        }catch (ResourceAccessException e){
            List<ProductDTO> products = new ArrayList<>();
            products = productService.findAllByIdBrandNotPage(product.getBrandId());
            model.addAttribute("productByBrands",products);
        }


        model.addAttribute("model",product);

        model.addAttribute("rating",rating);

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

    @GetMapping("/admin/product/search")
    public String searchProduct(@RequestParam(defaultValue = "") String keyword,
                                @RequestParam(defaultValue = "1") int page,
                                @RequestParam(defaultValue = "6") int limit,
                                Model model) {
        Page<ProductDTO> productDTOPage = productService.findByKeyword(keyword, page, limit);
        model.addAttribute("productPage", productDTOPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("brands", brandService.findAllByActive(true));
        if(!productDTOPage.getContent().isEmpty()){
            model.addAttribute("productLineId", productDTOPage.getContent().getFirst().getBrandId());
        }
        else{
            model.addAttribute("productLineId", null);
        }
        return "admin/product-view";
    }
}
