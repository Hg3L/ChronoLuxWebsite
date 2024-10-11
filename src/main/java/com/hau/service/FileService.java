package com.hau.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface FileService {
    String saveFile(MultipartFile file, String uploadDir) throws IOException;
    void deleteFile(String fileName, String uploadDir) throws IOException;
}
