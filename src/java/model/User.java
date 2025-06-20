/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nabil Nasri
 */

public class User {
    
    private int userId;
    private String fullName;
    private String email;
    private String password;

    // Constructors
    public User() {}
    
    public User(String fullName, String email, String password) {
        
        this.fullName = fullName;
        this.email = email;
        this.password = password;
    }

    // Getters and setters
    public int getUserId() { 
        return userId; 
    }
    
    public void setUserId(int userId) {
        this.userId = userId; 
    }
    
    public String getFullName() { 
        return fullName; 
    }
    
    public void setFullName(String fullName) { 
        this.fullName = fullName; 
    }
    
    public String getEmail() { 
        return email; 
    }
    
    public void setEmail(String email) { 
        this.email = email; 
    }
    
    public String getPassword() { 
        return password; 
    }
    
    public void setPassword(String password) { 
        this.password = password; 
    }
}