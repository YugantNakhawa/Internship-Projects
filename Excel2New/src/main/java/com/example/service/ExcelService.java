package com.example.service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.example.DTO.ClientDTO;
import com.example.DTO.EmployeeDTO;
import com.example.repository.ExcelRepository;

@Service
public class ExcelService {
	@Autowired
    private ExcelRepository excelRepository;
	

	public ByteArrayInputStream generateExcel() throws IOException {
        List<EmployeeDTO> employees = excelRepository.getEmployeeData();
        List<ClientDTO> clients = excelRepository.getClientData();
        Workbook workbook = new XSSFWorkbook();                  //1. create workbook
        Sheet sheet1 = workbook.createSheet("Employee Data");
        Sheet sheet2 = workbook.createSheet("Client Data");
        Row headerRow1 = sheet1.createRow(0);
        String[] columns1 = {
            "Employee ID", "Employee Name", "Username", "Manager ID", "Manager Name",
            "Project ID", "Project Name", "Designation ID", "Designation Name",
            "Type ID", "Type Name", "Client Name List"
        };
        for (int i = 0; i < columns1.length; i++) {
            Cell cell = headerRow1.createCell(i);
            cell.setCellValue(columns1[i]);
            cell.setCellStyle(getHeaderStyle(workbook));
        }
        int rowIdx1 = 1;                                   //2.Add data to sheet
        for (EmployeeDTO emp : employees) {
            Row row = sheet1.createRow(rowIdx1++);
            row.createCell(0).setCellValue(emp.getEmployeeId());
            row.createCell(1).setCellValue(emp.getEmployeeName());
            row.createCell(2).setCellValue(emp.getUsername());
            row.createCell(3).setCellValue(emp.getManagerId());
            row.createCell(4).setCellValue(emp.getManagerName());
            row.createCell(5).setCellValue(emp.getProjectId());
            row.createCell(6).setCellValue(emp.getProjectName());
            row.createCell(7).setCellValue(emp.getDesignationId());
            row.createCell(8).setCellValue(emp.getDesignationName());
            row.createCell(9).setCellValue(emp.getTypeId());
            row.createCell(10).setCellValue(emp.getTypeName());
            row.createCell(11).setCellValue(emp.getClientNameList() != null ? String.join(", ", emp.getClientNameList()) : "");
        }
        Row headerRow2 = sheet2.createRow(0);
        String[] columns2 = {"Client ID", "Client Name"};
        for (int i = 0; i < columns2.length; i++) {
            Cell cell = headerRow2.createCell(i);
            cell.setCellValue(columns2[i]);
            cell.setCellStyle(getHeaderStyle(workbook));
        }
        int rowIdx2 = 1;
        for (ClientDTO client : clients) {
            Row row = sheet2.createRow(rowIdx2++);
            row.createCell(0).setCellValue(client.getClientId());
            row.createCell(1).setCellValue(client.getClientName());
        }
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();  //3.convert to byte stream. create in-memory byte array output stream to store the Excel file's data
        workbook.write(outputStream);    //writes excel content into byte array
        workbook.close();       //close workbook
        return new ByteArrayInputStream(outputStream.toByteArray());   //converts byte array into inputStream
    }
    private CellStyle getHeaderStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        style.setFont(font);
        return style;
    }
}