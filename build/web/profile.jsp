<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriTrack Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #198754;
            --primary-dark: #146c43;
            --primary-light: #e8f5e9;
            --secondary-color: #388e3c;
            --accent-color: #4caf50;
            --text-dark: #2d3436;
            --text-medium: #636e72;
            --text-light: #b2bec3;
            --white: #ffffff;
            --light-bg: #f8f9fa;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.12);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
            --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-bg);
            color: var(--text-dark);
            line-height: 1.6;
        }

        .navbar {
            background-color: var(--primary-color);
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: var(--shadow-md);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            color: var(--white);
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .navbar-brand i {
            margin-right: 0.75rem;
            font-size: 1.8rem;
        }

        .navbar-nav {
            display: flex;
            list-style: none;
        }

        .nav-item {
            margin-left: 1.5rem;
        }

        .nav-link {
            color: var(--white);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
        }

        .nav-link i {
            margin-right: 0.5rem;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .btn {
            display: inline-block;
            padding: 0.6rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            transition: var(--transition);
            border: none;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }
        
        .btn-success {
            background-color: var(--accent-color);
            color: var(--white);
        }

        .btn-success:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid var(--white);
            color: var(--green); 
        }

        .btn-outline:hover {
            background-color: var(--white);
            color: var(--primary-color);
        }

        .main-content {
            margin-top: 80px;
            padding: 2rem;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: calc(100vh - 80px);
            background-color: var(--light-bg);
        }

        .profile-card {
            background-color: var(--white);
            border-radius: 1rem;
            box-shadow: var(--shadow-md);
            padding: 2.5rem;
            max-width: 600px;
            width: 100%;
            text-align: center;
            animation: fadeIn 0.8s ease-out forwards;
        }

        .profile-header {
            margin-bottom: 2rem;
        }

        .profile-header i {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .profile-header h2 {
            font-size: 2rem;
            color: var(--primary-dark);
            margin-bottom: 0.5rem;
        }

        .profile-header p {
            color: var(--text-medium);
            font-size: 1rem;
        }

        .profile-details {
            text-align: left;
            margin-bottom: 2rem;
        }

        .detail-item {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.75rem 1rem;
            background-color: var(--light-bg);
            border-radius: 0.5rem;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .detail-item i {
            font-size: 1.2rem;
            color: var(--primary-color);
            margin-right: 1rem;
            width: 25px;
            text-align: center;
        }

        .detail-label {
            font-weight: 500;
            color: var(--text-dark);
            flex-basis: 120px;
        }

        .detail-value {
            color: var(--text-medium);
            flex-grow: 1;
            padding: 2px 5px;
            border-radius: 3px;
        }

        .detail-value[contenteditable="true"],
        #profileName[contenteditable="true"],
        #profileTitle[contenteditable="true"] {
            outline: 2px solid var(--primary-color);
            background-color: #fff;
            box-shadow: var(--shadow-sm);
        }

        .profile-actions {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
            gap: 1rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .dashboard-page {
            background-image: linear-gradient(rgba(66, 66, 66, 0.5), rgba(61, 61, 61, 0.5)),
            url('img/dashboard.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                padding: 1rem;
            }
            .navbar-brand {
                margin-bottom: 1rem;
            }
            .navbar-nav {
                width: 100%;
                justify-content: space-around;
            }
            .nav-item {
                margin-left: 0;
            }
            .main-content {
                padding: 1rem;
            }
            .profile-card {
                padding: 1.5rem;
            }
            .profile-header i {
                font-size: 3rem;
            }
            .profile-header h2 {
                font-size: 1.8rem;
            }
            .detail-item {
                flex-direction: column;
                align-items: flex-start;
            }
            .detail-label {
                margin-bottom: 0.25rem;
                flex-basis: auto;
            }
            .detail-item i {
                margin-right: 0.5rem;
                margin-bottom: 0.5rem;
            }
        }
    </style>
</head>
<body class="dashboard-page">
    <nav class="navbar">
        <a href="dashboard.jsp" class="navbar-brand">
            <i class="fas fa-tractor"></i>
            AgriTrack
        </a>
        <ul class="navbar-nav">
            <li class="nav-item">
                <a href="dashboard.jsp" class="nav-link">
                    <i class="fas fa-home"></i> Dashboard
                </a>
            </li>

            <div class="user-actions">
                <a href="profile.jsp" class="btn btn-outline active"> <i class="fas fa-user-circle"></i> Profile
                </a>
            </div>
        </ul>
    </nav>

    <div class="main-content">
        <div class="profile-card">
            <div class="profile-header">
                <i class="fas fa-user-circle"></i>
                <%
                String userFullName = "";
                String userTitle = "";
                String userPhone = "";
                String userLocation = "";
                String userFarmSize = "";
                String userMainCrops = "";
                String userMemberSince = "";

                String userEmail = (String) session.getAttribute("userEmail");

                if (userEmail == null) {
                    response.sendRedirect("login.jsp?error=not_logged_in");
                    return;
                }

                String DB_URL = "jdbc:mysql://localhost:3308/agritrack";
                String DB_USER = "root";
                String DB_PASS = "admin11";

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                PreparedStatement insertStmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

                    String checkProfileSql = "SELECT full_name, title, phone_number, location, farm_size, main_crops, member_since FROM user_profiles WHERE email = ?";
                    stmt = conn.prepareStatement(checkProfileSql);
                    stmt.setString(1, userEmail);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        userFullName = rs.getString("full_name") != null ? rs.getString("full_name") : "";
                        userTitle = rs.getString("title") != null ? rs.getString("title") : "";
                        userPhone = rs.getString("phone_number") != null ? rs.getString("phone_number") : "";
                        userLocation = rs.getString("location") != null ? rs.getString("location") : "";
                        userFarmSize = rs.getString("farm_size") != null ? rs.getString("farm_size") : "";
                        userMainCrops = rs.getString("main_crops") != null ? rs.getString("main_crops") : "";
                        
                        Date memberDate = rs.getDate("member_since");
                        if (memberDate != null) {
                            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM dd,yyyy");
                            userMemberSince = sdf.format(memberDate);
                        } else {
                            userMemberSince = "";
                        }

                    } else {
                        String insertSql = "INSERT INTO user_profiles (email) VALUES (?)";
                        insertStmt = conn.prepareStatement(insertSql);
                        insertStmt.setString(1, userEmail);
                        insertStmt.executeUpdate();
                    }

                } catch (SQLException e) {
                    System.err.println("Database error loading/creating profile for " + userEmail + ": " + e.getMessage());
                } catch (ClassNotFoundException e) {
                    System.err.println("JDBC Driver not found: " + e.getMessage());
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (insertStmt != null) insertStmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        System.err.println("Error closing DB resources: " + e.getMessage());
                    }
                }
                %>
                <h2 id="profileName"><%= userFullName.isEmpty() ? "Your Name" : userFullName %></h2>
                <p id="profileTitle"><%= userTitle.isEmpty() ? "Your Title" : userTitle %></p>
            </div>

            <div class="profile-details">
                <div class="detail-item">
                    <i class="fas fa-envelope"></i>
                    <span class="detail-label">Email:</span>
                    <span class="detail-value" id="profileEmail"><%= userEmail %></span>
                </div>
                <div class="detail-item">
                    <i class="fas fa-phone"></i>
                    <span class="detail-label">Phone:</span>
                    <span class="detail-value" id="profilePhone"><%= userPhone %></span>
                </div>
                <div class="detail-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <span class="detail-label">Location:</span>
                    <span class="detail-value" id="profileLocation"><%= userLocation %></span>
                </div>
                <div class="detail-item">
                    <i class="fas fa-ruler-combined"></i>
                    <span class="detail-label">Farm Size:</span>
                    <span class="detail-value" id="profileFarmSize"><%= userFarmSize %></span>
                </div>
                <div class="detail-item">
                    <i class="fas fa-leaf"></i>
                    <span class="detail-label">Main Crops:</span>
                    <span class="detail-value" id="profileMainCrops"><%= userMainCrops %></span>
                </div>
                <div class="detail-item">
                    <i class="fas fa-calendar-alt"></i>
                    <span class="detail-label">Member Since:</span>
                    <span class="detail-value" id="profileMemberSince"><%= userMemberSince %></span>
                </div>
            </div>

            <div class="profile-actions">
                <a href="#" class="btn btn-primary" id="editProfileBtn">
                    <i class="fas fa-edit"></i> Edit Profile
                </a>
                <a href="dashboard.jsp" class="btn btn-outline">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const profileCard = document.querySelector('.profile-card');
            const editProfileBtn = document.getElementById('editProfileBtn');
            const detailValues = document.querySelectorAll('.profile-details .detail-value');
            const profileName = document.getElementById('profileName');
            const profileTitle = document.getElementById('profileTitle');

            if (profileCard) {
                profileCard.style.opacity = '0';
                setTimeout(() => {
                    profileCard.style.opacity = '1';
                }, 100);
            }

            let isEditing = false;

            editProfileBtn.addEventListener('click', function(event) {
                event.preventDefault();

                if (!isEditing) {
                    profileName.setAttribute('contenteditable', 'true');
                    profileTitle.setAttribute('contenteditable', 'true');
                    profileName.focus();

                    detailValues.forEach(value => {
                        if (value.id !== 'profileEmail') {
                            value.setAttribute('contenteditable', 'true');
                            value.style.border = '1px solid var(--primary-color)';
                            value.style.backgroundColor = '#fff';
                        }
                    });

                    editProfileBtn.innerHTML = '<i class="fas fa-save"></i> Save Changes';
                    editProfileBtn.classList.remove('btn-primary');
                    editProfileBtn.classList.add('btn-success');
                    isEditing = true;
                } else {
                    profileName.removeAttribute('contenteditable');
                    profileTitle.removeAttribute('contenteditable');

                    detailValues.forEach(value => {
                        value.removeAttribute('contenteditable');
                        value.style.border = '';
                        value.style.backgroundColor = '';
                    });

                    const updatedProfile = {
                        name: profileName.textContent.trim(),
                        title: profileTitle.textContent.trim(),
                        email: document.getElementById('profileEmail').textContent.trim(),
                        phone: document.getElementById('profilePhone').textContent.trim(),
                        location: document.getElementById('profileLocation').textContent.trim(),
                        farmSize: document.getElementById('profileFarmSize').textContent.trim(),
                        mainCrops: document.getElementById('profileMainCrops').textContent.trim(),
                        memberSince: document.getElementById('profileMemberSince').textContent.trim()
                    };

                    const formData = new URLSearchParams();
                    for (const key in updatedProfile) {
                        formData.append(key, updatedProfile[key]);
                    }

                    fetch('UpdateProfileServlet', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded'
                            },
                            body: formData.toString()
                        })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok: ' + response.statusText);
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success === 'true') {
                                alert('Profile saved successfully!');
                                if (data.memberSinceUpdated) {
                                    document.getElementById('profileMemberSince').textContent = data.memberSinceUpdated;
                                }
                            } else {
                                alert('Failed to save profile: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error saving profile:', error);
                            alert('An error occurred while saving the profile. Please try again.');
                        });

                    editProfileBtn.innerHTML = '<i class="fas fa-edit"></i> Edit Profile';
                    editProfileBtn.classList.remove('btn-success');
                    editProfileBtn.classList.add('btn-primary');
                    isEditing = false;
                }
            });
        });
    </script>
</body>
</html>