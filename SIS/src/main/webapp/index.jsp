<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, org.example.sis.entity.*" %>
<html>
<head>
  <title>Student Information System</title>
</head>
<body>
<h2>📘 Danh sách sinh viên và điểm</h2>

<table border="1" cellpadding="8" cellspacing="0">
  <tr>
    <th>Tên sinh viên</th>
    <th>Môn học</th>
    <th>Score1</th>
    <th>Score2</th>
    <th>Điểm tổng</th>
    <th>Grade</th>
  </tr>

  <%
    List<StudentScore> scores = (List<StudentScore>) request.getAttribute("scores");
    if (scores != null && !scores.isEmpty()) {
      for (StudentScore s : scores) {
        double score1 = s.getScore1();
        double score2 = s.getScore2();
        double finalScore = 0.3 * score1 + 0.7 * score2;
        String grade;

        if (finalScore >= 8.0) grade = "A";
        else if (finalScore >= 6.0) grade = "B";
        else if (finalScore >= 4.0) grade = "D";
        else grade = "F";
  %>
  <tr>
    <td><%= s.getStudent().getFullName() %></td>
    <td><%= s.getSubject().getSubjectName() %></td>
    <td><%= score1 %></td>
    <td><%= score2 %></td>
    <td><%= String.format("%.2f", finalScore) %></td>
    <td><%= grade %></td>
  </tr>
  <%
    }
  } else {
  %>
  <tr>
    <td colspan="6">No scores available</td>
  </tr>
  <%
    }
  %>
</table>

<br/>
<a href="addStudent.jsp">+ Thêm Sinh viên</a><br/>
<a href="addScore.jsp">+ Thêm Điểm</a>
</body>
</html>