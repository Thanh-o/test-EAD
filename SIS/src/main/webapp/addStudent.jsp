<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Student</title>
</head>
<body>
<h2>Thêm Sinh Viên</h2>
<form action="addStudent" method="post">
    <label>Student Code: <input type="text" name="studentCode" required></label><br/>
    <label>Full Name: <input type="text" name="fullName" required></label><br/>
    <label>Address: <input type="text" name="address" required></label><br/>
    <input type="submit" value="Add Student">
</form>
<a href="index">Back to List</a>
</body>
</html>