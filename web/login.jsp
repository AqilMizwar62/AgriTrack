<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - AgriTrack</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #fff;
            overflow: hidden;
        }

        .login-page {
            background-image: linear-gradient(rgba(66, 66, 66, 0.6), rgba(61, 61, 61, 0.6)),
                            url('img/agri.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            width: 100%;
            height: 100vh;
        }

        .form-inner {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
            transition: all 0.3s ease-in-out;
        }

        h2 {
            font-size: 32px;
            color: #333;
            margin-bottom: 25px;
            font-weight: 700;
            letter-spacing: 1.2px;
        }

        .field {
            margin-bottom: 20px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 16px 20px;
            font-size: 17px;
            border-radius: 8px;
            border: 1px solid #ddd;
            outline: none;
            background: #f8faff;
            margin-top: 8px;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #198754;
            background: #e9f5e9;
            box-shadow: 0 0 10px rgba(25, 135, 84, 0.2);
        }

        input[type="submit"] {
            display: inline-block;
            padding: 1rem 3rem;
            background-color: #198754;
            color: #fff;
            border-radius: 12px;
            text-decoration: none;
            font-weight: bold;
            font-size: 1.35rem;
            border: none;
            transition: background 0.3s ease, transform 0.2s ease;
            cursor: pointer;
            margin-top: 10px;
            width: auto;
            box-shadow: 0 4px 10px rgba(25, 135, 84, 0.3);
        }

        input[type="submit"]:hover {
            background-color: #146c43;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(20, 108, 67, 0.4);
        }

        .pass-link,
        .signup-link {
            font-size: 15px;
            color: #555;
            margin-top: 15px;
        }

        .signup-link {
            margin-top: 25px;
        }

        .pass-link a,
        .signup-link a {
            color: #198754;
            text-decoration: none;
            font-weight: 600;
        }

        .pass-link a:hover,
        .signup-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .form-inner {
                padding: 30px;
                width: 90%;
            }
            h2 {
                font-size: 28px;
            }
            input[type="submit"] {
                font-size: 1.1rem;
                padding: 0.8rem 2.5rem;
            }
        }
    </style>
</head>

<body class="login-page">
    <div class="form-inner">
        <h2>AgriTrack Login</h2>
        <form action="LoginServlet" method="POST" class="login">
            <div class="field">
                <input type="text" placeholder="Email Address" name="email" required>
            </div>
            <div class="field">
                <input type="password" placeholder="Password" name="password" required>
            </div>
            <div class="field btn">
                <input type="submit" value="Login">
            </div>
            <div class="signup-link">Don't have an account? <a href="Signup.jsp">Signup now</a></div>
            <div class="pass-link"><a href="forgot_password.jsp">Forgot Password?</a></div>
        </form>
        <%
            String error = request.getParameter("error");
            if (error != null) {
                String errorMessage = "";
                if (error.equals("empty_fields")) {
                    errorMessage = "Please fill in all fields.";
                } else if (error.equals("invalid_credentials")) {
                    errorMessage = "Invalid email or password.";
                } else if (error.equals("user_not_found")) {
                    errorMessage = "User not found. Please sign up.";
                } else if (error.equals("database_driver_error")) {
                    errorMessage = "Server error: Database driver not found.";
                } else if (error.equals("database_connection_error")) {
                    errorMessage = "Server error: Could not connect to database.";
                } else {
                    errorMessage = "An unexpected error occurred.";
                }
        %>
            <p style="color: red; margin-top: 15px;"><%= errorMessage %></p>
        <%
            }
        %>
    </div>

    <script>
        document.querySelector('.login').addEventListener('submit', function(e) {
            const email = document.querySelector('input[name="email"]');
            const password = document.querySelector('input[name="password"]');
            let valid = true;
            let message = "";

            if (!email.value.includes('@')) {
                valid = false;
                message += "Email must contain '@'.\n";
            }
            if (password.value.length < 6) {
                valid = false;
                message += "Password must be at least 6 characters long.\n";
            }
            if (!valid) {
                alert(message);
                e.preventDefault();
            }
        });
        
        window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const signupStatus = urlParams.get('signup');

        if (signupStatus === 'success') {
            alert("Successfully signed up! You can now log in.");
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    };
    </script>
</body>
</html>