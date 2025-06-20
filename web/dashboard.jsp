<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriTrack Dashboard</title>
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

        /* Navbar Styles */
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

        .btn-outline {
            background-color: transparent;
            border: 2px solid var(--white);
            color: var(--white);
        }

        .btn-outline:hover {
            background-color: var(--white);
            color: var(--primary-color);
        }

        .main-content {
            margin-top: 80px;
            padding: 2rem;
        }

        .hero {
            background: linear-gradient(135deg, var(--primary-light) 0%, #f1f8e9 100%);
            border-radius: 1rem;
            padding: 3rem 2rem;
            margin-bottom: 3rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
        }

        .hero::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path fill="%23198754" fill-opacity="0.05" d="M0,0 L100,0 L100,100 L0,100 Z"></path></svg>');
            background-size: cover;
            z-index: 0;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 800px;
            margin: 0 auto;
        }

        .hero h1 {
            color: var(--primary-dark);
            font-size: 2.5rem;
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .hero p {
            color: var(--secondary-color);
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }

        .hero-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }

        /* Stats Section */
        .stats-section {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background-color: var(--white);
            border-radius: 0.75rem;
            padding: 1.5rem;
            flex: 1;
            min-width: 200px;
            text-align: center;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .stat-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--text-medium);
            font-size: 1rem;
        }

        /* Features Section */
        .section-title {
            text-align: center;
            margin-bottom: 3rem;
            position: relative;
        }

        .section-title h2 {
            font-size: 2rem;
            color: var(--primary-dark);
            display: inline-block;
            padding-bottom: 0.5rem;
        }

        .section-title h2::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background-color: var(--primary-color);
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .feature-card {
            background-color: var(--white);
            border-radius: 0.75rem;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .feature-img {
            height: 180px;
            overflow: hidden;
        }

        .feature-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .feature-card:hover .feature-img img {
            transform: scale(1.05);
        }

        .feature-content {
            padding: 1.5rem;
        }

        .feature-content h3 {
            color: var(--primary-dark);
            margin-bottom: 1rem;
            font-size: 1.3rem;
        }

        .feature-content p {
            color: var(--text-medium);
            margin-bottom: 1.5rem;
        }

        /* Quick Actions */
        .quick-actions {
            background-color: var(--white);
            border-radius: 0.75rem;
            padding: 2rem;
            margin-bottom: 3rem;
            box-shadow: var(--shadow-sm);
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .action-card {
            background-color: var(--primary-light);
            border-radius: 0.75rem;
            padding: 1.5rem;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(25, 135, 84, 0.1);
        }

        .action-card:hover {
            background-color: var(--primary-color);
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .action-card:hover * {
            color: var(--white);
        }

        .action-icon {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
            transition: var(--transition);
        }

        .action-card:hover .action-icon {
            color: var(--white);
            transform: scale(1.1);
        }

        .action-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--primary-dark);
            transition: var(--transition);
        }

        .action-btn {
            display: inline-block;
            padding: 0.5rem 1.25rem;
            background-color: var(--primary-color);
            color: var(--white);
            border-radius: 0.5rem;
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }

        .action-card:hover .action-btn {
            background-color: var(--white);
            color: var(--primary-color);
        }

        .farm-tips-section {
            background-color: var(--white);
            border-radius: 0.75rem;
            padding: 2rem;
            margin-bottom: 3rem;
            box-shadow: var(--shadow-sm);
            text-align: center;
        }

        .farm-tips-section h3 {
            color: var(--primary-dark);
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            position: relative;
            padding-bottom: 0.5rem;
            display: inline-block;
        }

        .farm-tips-section h3::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background-color: var(--primary-color);
        }

        .slideshow-container {
            position: relative;
            max-width: 700px;
            margin: auto;
            overflow: hidden;
            border-radius: 0.75rem;
            box-shadow: var(--shadow-md);
        }

        .mySlides {
            display: none;
            width: 100%;
            height: 400px; 
            border-radius: 0.75rem;
        }

        .mySlides img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .fade {
            animation-name: fade;
            animation-duration: 1.5s;
        }

        @keyframes fade {
            from {opacity: .4}
            to {opacity: 1}
        }

        @media (max-width: 992px) {
            .hero h1 {
                font-size: 2rem;
            }
            
            .hero p {
                font-size: 1.1rem;
            }
            
            .stats-section {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .navbar {
                padding: 1rem;
                flex-direction: column;
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
            
            .hero {
                padding: 2rem 1rem;
            }
            
            .hero h1 {
                font-size: 1.8rem;
            }
            
            .hero-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .hero-buttons .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }
            
            .stats-section {
                grid-template-columns: 1fr;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }

            .mySlides {
                height: 250px; /* Adjusted height for smaller screens */
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }

        .delay-1 {
            animation-delay: 0.2s;
        }

        .delay-2 {
            animation-delay: 0.4s;
        }

        .delay-3 {
            animation-delay: 0.6s;
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
    </style>
</head>
<body class="dashboard-page">
    <nav class="navbar">
        <a href="#" class="navbar-brand">
            <i class="fas fa-tractor"></i>
            AgriTrack
        </a>
        <ul class="navbar-nav">
            <li class="nav-item">
                <a href="#" class="nav-link active">
                    <i class="fas fa-home"></i> Dashboard
                </a>
            </li>
            
            <div class="user-actions">
                <a href="profile.jsp" class="btn btn-outline">
                    <i class="fas fa-user-circle"></i> Profile
                </a>
            </div>
        </ul>
    </nav>

    <div class="main-content">
        <section class="hero fade-in">
            <div class="hero-content">
                <h1>Welcome Back, Farmer!</h1>
                <p>Manage your farm operations efficiently with AgriTrack's powerful tools and analytics.</p>
            </div>
        </section>

        <section class="quick-actions fade-in delay-2">
            <h2 class="section-title">
                <span>Quick Actions</span>
            </h2>
            <div class="actions-grid">
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-seedling"></i>
                    </div>
                    <h3 class="action-title">Add New Crop</h3>
                    <a href="crops.jsp" class="action-btn">Start Now</a>
                </div>
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-tractor"></i>
                    </div>
                    <h3 class="action-title">Equipment Check</h3>
                    <a href="equipment.jsp" class="action-btn">Inspect</a>
                </div>
                <div class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-tasks"></i>
                    </div>
                    <h3 class="action-title">Harvest Check</h3>
                    <a href="harvest.jsp" class="action-btn">Schedule</a>
                </div>
            </div>
        </section>

        ---

        <section class="farm-tips-section fade-in delay-3">
            <h3><i class="fas fa-lightbulb me-2"></i>Farm Tips</h3>
            <div class="slideshow-container">
                <a href="https://krishispray.in/blog/9-top-tips-for-maintaining-a-thriving-agricultural-farm" target="_blank" class="mySlides fade">
                    <img src="img/tips1.jpg" alt="Farm Tip Image 1: Sustainable Farming">
                </a>
                <a href="https://youtu.be/K1kBDFXESXE?si=nZ8NC31p_vGyisrh" target="_blank" class="mySlides fade">
                    <img src="img/tips2.jpg" alt="Farm Tip Image 2: Crop Management">
                </a>
                <a href="https://www.agrifarming.in/agriculture-tips-for-farmers-farming-tips" target="_blank" class="mySlides fade">
                    <img src="img/tips3.jpg" alt="Farm Tip Image 3: Soil Health">
                </a>
                </div>
            <br>
            <br>
        </section>
        </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.fade-in');
            elements.forEach(el => {
                el.style.opacity = '0';
            });
            
            setTimeout(() => {
                elements.forEach(el => {
                    el.style.opacity = '1';
                });
            }, 100);
        });
        
        document.querySelector('.weather-refresh')?.addEventListener('click', function() {
            this.querySelector('i').classList.add('fa-spin');
            setTimeout(() => {
                this.querySelector('i').classList.remove('fa-spin');
            }, 1000);
        });

        let slideIndex = 0;
        showSlides();

        function showSlides() {
            let i;
            let slides = document.querySelectorAll(".slideshow-container .mySlides"); 
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";  
            }
            slideIndex++;
            if (slideIndex > slides.length) {slideIndex = 1}    
            slides[slideIndex-1].style.display = "block";  
            setTimeout(showSlides, 4000); // Change image every 4 seconds
        }
    </script>
</body>
</html>