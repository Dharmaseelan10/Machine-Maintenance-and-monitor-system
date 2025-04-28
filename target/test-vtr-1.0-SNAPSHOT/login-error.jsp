<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authentication Error</title>
    <script src="css/tailwindcss.5"></script>
    <link href="css/cloudfare.css" rel="stylesheet"/></head>
<body class="bg-gray-100 flex">
    <!-- Sidebar -->
    <jsp:include page="sidebar.jsp" />
    
    <!-- Main Content -->
    <div class="w-4/5 p-6" style="margin-left: 20%;">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-bold text-red-600">Authentication Error</h2>
        </div>

        <div class="mt-6 p-4 bg-white rounded shadow-md">
            <div class="flex items-center mb-4">
                <i class="fas fa-exclamation-triangle text-yellow-600 mr-2"></i>
                <h3 class="text-lg font-semibold">Login Failed</h3>
            </div>
            <p class="text-gray-700">
                Your username or password is incorrect. Please try again.
            </p>
            <p class="text-gray-700 mt-2">
                Only Vision members have access to this page. If you are not a Vision member, you are restricted from entering this page.
            </p>
            <p class="text-gray-700 mt-2">
                If you are a Vision member and have forgotten your username or password, please contact the BE team for assistance.
            </p>
            <div class="flex justify-between items-center mt-6">
                <a class="block py-2.5 px-4 rounded bg-green-500 text-white transition duration-200 hover:bg-green-600" href="Form.jsp">
                    Back to Home
                </a>
            </div>
        </div>
    </div>
</body>
</html>