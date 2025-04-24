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
    }

    h1 {
      background-color: #3d5a40;
      color: white;
      padding: 20px;
      margin: 0;
    }

    .container {
      width: 90%;
      max-width: 1200px;
      background-color: white;
      padding: 20px;
    }

    .sub-heading {
      text-align: center;
      font-size: 28px;
      font-weight: bold;
      color: #3d5a40;
    }

    .btn {
      display: inline-block;
      margin: 10px 10px 20px 0;
      padding: 10px 20px;
      background-color: #3d5a40;
      color: white;
      text-decoration: none;
      border-radius: 6px;
    }

    .btn:hover {
      background-color: #2e4230;
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

    .edit-icon {
      width: 20px;
      height: 20px;
      fill: #007bff;
      vertical-align: middle;
    }

    .edit-link {
      text-decoration: none;
    }

  </style>
</head>
<body>
<h1>Student Information System</h1>

<div class="container">
  <div class="sub-heading">Student Information</div>

  <a class="btn" href="addStudent.jsp">+ Student</a>
  <a class="btn" href="addScore.jsp">+ Score</a>

  <table>
    <thead>
    <tr>
      <th>Id</th>
      <th>Student Id</th>
      <th>Student Name</th>
      <th>Subject Name</th>
      <th>Score 1</th>
      <th>Score 2</th>
      <th>Credit</th>
      <th>Grade</th>
      <th></th>
    </tr>
    </thead>
    <tbody>
    <%
      List<StudentScore> scores = (List<StudentScore>) request.getAttribute("scores");
      if (scores != null && !scores.isEmpty()) {
        int count = 1;
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
      <td><%= count++ %></td>
      <td><%= s.getStudent().getStudentId() %></td>
      <td><%= s.getStudent().getFullName() %></td>
      <td><%= s.getSubject().getSubjectName() %></td>
      <td><%= score1 %></td>
      <td><%= score2 %></td>
      <td><%= s.getSubject().getCredit() %></td>
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
      <td colspan="9">No scores available</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>
</body>
</html>
