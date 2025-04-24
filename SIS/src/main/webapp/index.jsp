<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, org.example.sis.entity.*" %>
<html>
<head>
  <title>Student Information System</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
    }

    h2 {
      background-color: #3d5a40;
      color: white;
      padding: 20px;
      margin: 0;
      text-align: center;
    }

    .container {
      margin: 30px auto;
      width: 90%;
      max-width: 1000px;
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      padding: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    table thead {
      background-color: #3d5a40;
      color: white;
    }

    table th, table td {
      padding: 20px;
      text-align: center;

    }



    .a {
      display: inline-block;
      margin-top: 20px;
      padding: 10px 16px;
      background-color: #3d5a40;
      color: white;
      text-decoration: none;
      border-radius: 6px;
    }

    a:hover {
      background-color: #2e4230;
    }

    .edit-link {
      text-decoration: none;
    }

    .edit-cell {
      text-align: center;
    }
  </style>
</head>
<body>
<h2>Student Information System</h2>

<div class="container">
  <h2>Student Information</h2>

  <a class="a" href="addStudent.jsp">+ Add Student</a>
  <a class="a" href="addScore.jsp">+ Add Score</a>
  <table>
    <thead>
    <tr>
      <th>Student Name</th>
      <th>Subject</th>
      <th>Score 1</th>
      <th>Score 2</th>
      <th>Final Score</th>
      <th>Grade</th>
      <th>Edit</th>
    </tr>
    </thead>
    <tbody>
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
      <td><a class="edit-link" href="editScore.jsp?id=<%= s.getStudent().getStudentId() %>">
        <svg class="edit-icon" viewBox="0 0 24 24">
          <path d="M3 17.25V21h3.75l11.06-11.06-3.75-3.75L3 17.25zm3.98-1.31L14.06 8.86l1.8 1.8-7.09 7.08H6.98v-1.8zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34a1.003 1.003 0 00-1.42 0l-1.83 1.83 3.75 3.75 1.84-1.83z"/>
        </svg>
      </a></td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="7">No scores available</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>

</div>
</body>
</html>
