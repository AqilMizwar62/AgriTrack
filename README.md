# AgriTrack 🌾

AgriTrack is a web-based farm management system developed using Java (Servlets/JSP) and MySQL. It helps farmers and agricultural managers organize crop information, plan harvests, and monitor productivity with a user-friendly interface.

---

## 📦 Project Overview

This system aims to digitalize agricultural data tracking, making farm operations more efficient. Users can:
- Register and log in
- Add and manage crops
- Track and maintain farming equipment
- Plan and manage harvest schedules
- View reports of past and upcoming harvests

---

## 🧩 Module Responsibilities

| Module | Description |
|--------|-------------|
| User Management | Handles user registration, login, profile editing, and authentication |
| Crop Module | Add, update, delete crop records with attributes like type, location, dates, and status |
| Equipment Tracking | Add and maintain equipment data, including type, status, and maintenance history |
| Harvest Planner | Create and manage harvest plans based on crop readiness and resources |
| Reports | Displays summaries of crops, harvests, and equipment status |
| Database Connectivity | JDBC-based interaction with MySQL database (agritrack) |

---

## 🏗 MVC Architecture

AgriTrack follows the Model-View-Controller (MVC) architecture to maintain separation of concerns:

### 🔹 Model (JavaBeans + MySQL)
- Database name: agritrack
- JavaBeans:
  - Crop.java, Equipment.java, HarvestPlan.java, SuggestedCrop.java, User.java
- DAO classes:
  - CropDAO.java, EquipmentDAO.java, HarvestDAO.java, SuggestedCropDAO.java, UserDAO.java
- DB connection handled by: DBConnection.java

### 🔹 View (JSP + CSS + JS)
- JSP Pages: crops.jsp, equipment.jsp, harvest.jsp, dashboard.jsp, login.jsp, etc.
- JavaScript for form validation
- CSS for clean, responsive interface

### 🔹 Controller (Servlets)
- Core Module Servlets:
  - CropServlet.java, EquipmentServlet.java, HarvestServlet.java
- User Management Servlets:
  - LoginServlet.java, LogoutServlet.java, SignupServlet.java, UpdateProfileServlet.java

---

## 👥 Team Members & Contributions

| Name | Matric No. | Module |
|------|------------|--------|
| Aqil Mizwar Bin Mohd Roslan | S72471 | Harvest Scheduling |
| Wan Aimi Firdaus Bin Wan Azarie | S72577 | Equipment Tracking |
| Muhammad Nabil Nasri Bin Mohamad Nasir | S72398 | Crop Management |

---

## ⚙️ Setup Instructions

1. Requirements
   - NetBeans (v12 or later recommended)
   - XAMPP (MySQL + Apache)
   - Java JDK 8 or later

2. Installation
   - Import the project into NetBeans
   - Start Apache and MySQL in XAMPP
   - Create a MySQL database named agritrack
   - Import the provided .sql file (if any) into the database
   - Run the project on Apache Tomcat via NetBeans

3. Accessing the App
   - Navigate to http://localhost:8080/AgriTrack/ in your browser

---

## 🔗 Links

- GitHub Repository: [https://github.com/AqilMizwar62/AgriTrack](https://github.com/AqilMizwar62/AgriTrack)
- Deployment URL: _Login - AgriTrack_ (URL not specified in submission)

---

## 📄 License

This project is developed as part of the Web-Based Application Development (CSE3023) coursework at Universiti Malaysia Terengganu.
