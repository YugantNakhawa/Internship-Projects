package com.example.repository;

import com.example.DTO.EmployeeDTO;

import java.util.List;

import com.example.DTO.ClientDTO;

public interface ExcelRepository {
	List<EmployeeDTO> getEmployeeData();  // Returns a list of EmployeeDTO objects
    List<ClientDTO> getClientData();     // Returns a list of ClientDTO objects
}

