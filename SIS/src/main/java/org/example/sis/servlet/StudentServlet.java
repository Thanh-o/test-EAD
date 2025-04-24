package org.example.sis.servlet;

import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.example.sis.entity.Student;
import org.example.sis.entity.StudentScore;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "StudentServlet", urlPatterns = {"/", "/index", "/editScore"})
public class StudentServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        try {
            emf = Persistence.createEntityManagerFactory("SISPU");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize EntityManagerFactory: " + e.getMessage(), e);
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }

    // Handle GET requests to display student scores
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try {
            List<StudentScore> scores = em.createQuery("SELECT s FROM StudentScore s", StudentScore.class).getResultList();
            req.setAttribute("scores", scores);
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error retrieving student scores: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    // Handle POST requests for adding new student and editing scores
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/editScore".equals(path)) {
            // Handle score editing
            String id = req.getParameter("id");
            String score1Str = req.getParameter("score1");
            String score2Str = req.getParameter("score2");

            // Input validation
            if (id == null || score1Str == null || score2Str == null ||
                    id.trim().isEmpty() || score1Str.trim().isEmpty() || score2Str.trim().isEmpty()) {
                throw new ServletException("Missing or invalid score details");
            }

            try {
                double score1 = Double.parseDouble(score1Str);
                double score2 = Double.parseDouble(score2Str);

                // Validate score ranges
                if (score1 < 0 || score1 > 10 || score2 < 0 || score2 > 10) {
                    throw new ServletException("Scores must be between 0 and 10");
                }

                EntityManager em = emf.createEntityManager();
                try {
                    em.getTransaction().begin();
                    StudentScore score = em.find(StudentScore.class, Long.parseLong(id));
                    if (score == null) {
                        throw new ServletException("Score record not found");
                    }
                    score.setScore1(score1);
                    score.setScore2(score2);
                    em.merge(score);
                    em.getTransaction().commit();
                } finally {
                    em.close();
                }
            } catch (NumberFormatException e) {
                throw new ServletException("Invalid score format: " + e.getMessage());
            }

            resp.sendRedirect("index");
        } else {
            // Handle adding new student (existing functionality)
            String code = req.getParameter("studentCode");
            String name = req.getParameter("fullName");
            String address = req.getParameter("address");

            // Basic input validation
            if (code == null || name == null || address == null ||
                    code.trim().isEmpty() || name.trim().isEmpty()) {
                throw new ServletException("Missing or invalid student details");
            }

            Student s = new Student();
            s.setStudentCode(code);
            s.setFullName(name);
            s.setAddress(address);

            EntityManager em = emf.createEntityManager();
            try {
                em.getTransaction().begin();
                em.persist(s);
                em.getTransaction().commit();
            } finally {
                em.close();
            }

            resp.sendRedirect("index");
        }
    }
}