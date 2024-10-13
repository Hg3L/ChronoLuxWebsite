package com.hau.util;

import com.google.gson.internal.LinkedTreeMap;
import com.hau.dto.ProductDTO;
import com.hau.entity.ProductEntity;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.ui.Model;

import java.util.Map;

public class PageableUtil {
    public static Pageable getInstance(int page,int limit,String sortName,String sortBy){
            if(sortName != null && sortBy !=null){
                if(sortBy.equals("desc") ){
                    return  new PageRequest(page-1,limit, Sort.Direction.DESC,sortName);
                }
                else if(sortBy.equals("asc") ){
                    return  new PageRequest(page-1,limit, Sort.Direction.ASC,sortName);
                }
            }
            else{
                return new PageRequest(page-1,limit);
            }

        return null;
    }
    public static void applyFiltersAndSorting(ProductDTO product,int page,int limit, String sortName, String sortBy,
                                       String keyword, String filter, Model model) {
        product.setPage(page);
        product.setLimit(limit);
        // Kiểm tra và thiết lập thông tin sắp xếp
        if (sortName != null && sortBy != null) {
            product.setSortName(sortName);
            product.setSortBy(sortBy);
        }

        // Thiết lập từ khóa tìm kiếm nếu có
        if (keyword != null) {
            product.setKeyword(keyword);
        }

        // Thiết lập bộ lọc và thêm vào model nếu filter không rỗng
        if (filter != null) {
            Map<String, String> priceFilters = new LinkedTreeMap<>();
            priceFilters.put("nam", "Nam");
            priceFilters.put("nu", "Nữ");
            priceFilters.put("duoi-1-trieu", "Dưới 1 triệu");
            priceFilters.put("tu-1-3-trieu", "Từ 1 - 3 triệu");
            priceFilters.put("tu-3-6-trieu", "Từ 3 - 6 triệu");
            priceFilters.put("tu-6-9-trieu", "Từ 6 - 9 triệu");
            priceFilters.put("tren-9-trieu", "Trên 9 triệu");

            // Thêm filter vào model
            model.addAttribute("filter", filter);
            product.setFilter(filter);
            model.addAttribute("priceFilters", priceFilters);
        }
    }
}
