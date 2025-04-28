<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Login</title>
  <meta content="" name="description">
  <meta content="" name="keywords">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
    }

    .container {
      
      border-radius: 10px;
      padding: 30px;
      text-align: center;
    }

   
    .logo img {
      width: 150px;
    }

    .card {
      background-color: #fff;
      padding: 20px;
      border: 1px solid #ddd;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
      width: 300px;
    }

    .card-body {
      padding: 20px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-label {
      display: block;
      margin-bottom: 10px;
      font-weight: bold;
      text-align: left; 
    }

    .form-control {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .btn {
      background-color: #4CAF50;
      color: #fff;
      padding: 10px 20px;
      border: none;
      border-radius: 5px; cursor: pointer;
    }

    .btn:hover {
      background-color: #3e8e41;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="logo">
     <img alt="Murata Logo" class="mb-4" height="100" src="css/murata_logo.png" width="200"/>
  </div>
    <div class="card">
      <div class="card-body">
        <h2 class="card-title text-center pb-0 fs-4">Vision Admin Login</h2>
        <p class="text-center small">Login to Your Account</p>
        <form id="msform" action="j_security_check" method="POST">
          <div class="form-group">
            <label for="j_username" class="form-label">Username</label>
            <input type="text" name="j_username" class="form-control" id="j_username" required>
          </div>
          <div class="form-group">
            <label for="j_password" class="form-label">Password</label>
            <input type="password" name="j_password" class="form-control" id="j_password" required>
          </div>
          <div class="form-group">
            <button class="btn" type="submit">Login</button>
      
          
            <a href="Form.jsp"><button class="btn" type="button">Home</button></a>
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>