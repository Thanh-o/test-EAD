<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.sis.entity.*, jakarta.persistence.*" %>
<html>
<head>
  <title>Edit Score - Student Information System</title>
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
      max-width: 600px;
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      padding: 20px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
      color: #333;
    }

    input[type="text"], input[type="number"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
    }

    input[type="submit"] {
      padding: 10px 20px;
      background-color: #3d5a40;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    input[type="submit"]:hover {
      background-color: #2e4230;
    }

    .back-link {
      display: inline-block;
      margin-top: 20px;
      padding: 10px 16px;
      background-color: #3d5a40;
      color: white;
      text-decoration: none;
      border-radius: 6px;
    }

    .back-link:hover {
      background-color: #2e4230;
    }

    .error {
      color: red;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>
<h2>Edit Student Score</h2>

<div class="container">
  <%
    String id = request.getParameter("id");
    StudentScore score = null;
    if (id != null && !id.isEmpty()) {
      EntityManagerFactory emf = Persistence.createEntityManagerFactory("SISPU");
      EntityManager em = emf.createEntityManager();
      try {
        score = em.find(StudentScore.class, Long.parseLong(id));
      } finally {
        em.close();
      }
    }

    if (score == null) {
  %>
  <p class="error">Score record not found.</p>
  <a class="back-link" href="index">Back to List</a>
  <%
  } else {
  %>
  <form action="editScore" method="post">
    <input type="hidden" name="id" value="<%= score.getStudent().getStudentId() %>">

    <div class="form-group">
      <label for="studentName">Student Name</label>
      <input type="text" id="studentName" value="<%= score.getStudent().getFullName() %>" disabled>
    </div>

    <div class="form-group">
      <label for="subject">Subject</label>
      <input type="text" id="subject" value="<%= score.getSubject().getSubjectName() %>" disabled>
    </div>

    <div class="form-group">
      <label for="score1">Score 1</label>
      <input type="number" id="score1" name="score1" value="<%= score.getScore1() %>" step="0.1" min="0" max="10" required>
    </div>

    <div class="form-group">
      <label for="score2">Score 2</label>
      <input type="number" id="score2" name="score2" value="<%= score.getScore2() %>" step="0.1" min="0" max="10" required>
    </div>

    <input type="submit" value="Update Score">
  </form>
  <a class="back-link" href="index">Cancel</a>
  <%
    }
  %>
</div>
</body>
</html>