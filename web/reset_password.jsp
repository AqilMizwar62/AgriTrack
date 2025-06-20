<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Reset Password</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: #f8faff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .form-container {
            background: #fff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }
        h2 {
            color: #198754;
            margin-bottom: 25px;
        }
        input[type="password"] {
            width: 100%;
            padding: 14px 18px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            background: #f8faff;
            transition: border 0.3s;
        }
        input[type="password"]:focus {
            border-color: #198754;
            outline: none;
        }
        button[type="submit"] {
            background: #198754;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 12px 32px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        button[type="submit"]:hover {
            background: #146c43;
        }
        .error {
            color: #d9534f;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Reset Password</h2>
        <form action="ResetPasswordServlet" method="post">
            <input type="hidden" name="email" value="${email}" />
            <input type="password" name="password" placeholder="Enter new password" required />
            <button type="submit">Reset Password</button>
        </form>
        <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
    </div>
</body>
</html>