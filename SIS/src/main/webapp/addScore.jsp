<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Student Score</title>
</head>
<body>
<h2>Thêm Điểm Sinh Viên</h2>
<form action="addScore" method="post">
    <label>Student ID: <input type="number" name="studentId" required></label><br/>
    <label>Subject ID: <input type="number" name="subjectId" required></label><br/>
    <label>Score 1: <input type="number" step="0.01" name="score1" required></label><br/>
    <label>Score 2: <input type="number" step="0.01" name="score2" required></label><br/>
    <input type="submit" value="Add Score">
</form>
<a href="index">Back to List</a>
</body>
</html>