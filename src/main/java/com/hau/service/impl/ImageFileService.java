package com.hau.service.impl;

import com.hau.service.FileService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Service
public class ImageFileService implements FileService {
    private static final String ROOT_DIR = "G:/JAVA SPRING/Learn Spring/ChronoLuxWebsite/src/main/webapp/template/web/img/";
    @Override
    public String saveFile(MultipartFile file, String uploadDir) throws IOException {
        Path filePath = Paths.get(ROOT_DIR + uploadDir + "/" + file.getOriginalFilename());
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        return file.getOriginalFilename();
    }

    @Override
    public void deleteFile(String fileName, String uploadDir) throws IOException {
        Path filePath = Paths.get(ROOT_DIR + uploadDir + "/" + fileName);
        Files.deleteIfExists(filePath);
    }
}
