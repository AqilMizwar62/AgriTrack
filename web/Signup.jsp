<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: 'Arial', sans-serif;
        background: linear-gradient(135deg, #6e7dff, #82a4e7);
        justify-content: center;
        align-items: center;
        height: 100vh;
        color: #fff;
        display: flex;
      }

      .form-inner {
        background: rgba(255, 255, 255, 0.8);
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 380px;
        text-align: center;
      }

      h2 {
        font-size: 28px;
        color: #333;
        margin-bottom: 20px;
        font-weight: 600;
        letter-spacing: 1px;
      }

      h3 {
        font-size: 18px;
        color: #333;
        margin-bottom: 20px;
        font-weight: 600;
        letter-spacing: 1px;
      }

      .field {
        margin-bottom: 20px;
      }

      input[type="text"],
      input[type="password"],
      input[type="email"] {
        width: 100%;
        padding: 15px;
        font-size: 16px;
        border-radius: 8px;
        border: 1px solid #ddd;
        outline: none;
        background: #f4f7fc;
        margin-top: 8px;
        transition: all 0.3s ease;
      }

      input[type="text"]:focus,
      input[type="password"]:focus,
      input[type="email"]:focus {
        border-color: #6e7dff;
        background: #e8f0fe;
        box-shadow: 0 0 8px rgba(110, 125, 255, 0.3);
      }

      input[type="submit"] {
        display: inline-block;
        padding: 0.75rem 2.5rem;
        background-color: #188754;
        color: #fff;
        border-radius: 12px;
        text-decoration: none;
        font-weight: bold;
        font-size: 1.25rem;
        border: none;
        transition: background 0.3s;
        cursor: pointer;
        margin-top: 0;
        width: auto;
      }

      input[type="submit"]:hover {
        background-color: #146c43;
        color: #fff;
        transform: none;
      }

      .pass-link,
      .login-link {
        font-size: 14px;
        color: #555;
        margin-top: 10px;
      }

      .login-link {
        margin-top: 20px;
      }

      .pass-link a,
      .login-link a {
        color: #6e7dff;
        text-decoration: none;
      }

      .pass-link a:hover,
      .login-link a:hover {
        text-decoration: underline;
      }

      .back-link {
        margin-top: 20px;
        text-align: center;
        font-size: 14px;
      }

      .back-link a {
        color: #6e7dff;
        text-decoration: none;
      }

      .back-link a:hover {
        text-decoration: underline;
      }

      @media (max-width: 480px) {
        .form-inner {
          padding: 30px;
          width: 90%;
        }
        h2 {
          font-size: 24px;
        }
      }

      .signup-page {
        background-image: linear-gradient(rgba(66, 66, 66, 0.5), rgba(61, 61, 61, 0.5)),
        url('img/agri.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        min-height: 100vh;
        margin: 0;
        padding: 0;
      }
    </style>
</head>

<body class="signup-page">
    <div class="form-inner">
        <h2>Signup</h2>
        <form action="SignupServlet" method="POST" class="signup">
            <div class="field">
                <input type="email" placeholder="Email Address" name="email" required>
            </div>
            <div class="field">
                <input type="password" placeholder="Password" name="password" required>
            </div>
            <div class="field">
                <input type="password" placeholder="Confirm Password" name="confirm_password" required>
            </div>
            <div class="field btn">
                <input type="submit" value="Signup">
            </div>
            <div class="login-link">Already have an account? <a href="login.jsp">Login now</a></div>
        </form>
    </div>

  <script>
    document.querySelector('.signup').addEventListener('submit', function(e) {
        const email = document.querySelector('input[name="email"]');
        const password = document.querySelector('input[name="password"]');
        const confirmPassword = document.querySelector('input[name="confirm_password"]');
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
        if (password.value !== confirmPassword.value) {
            valid = false;
            message += "Passwords do not match.\n";
        }
        if (!valid) {
            alert(message);
            e.preventDefault();
        }
    });
  </script>
</body>
</html> 