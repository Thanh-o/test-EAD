package org.example.sis.servlet;

import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.example.sis.entity.Student;
import org.example.sis.entity.StudentScore;
import org.example.sis.entity.Subject;

import java.io.IOException;

@WebServlet(name = "ScoreServlet", urlPatterns = {"/addScore"})
public class ScoreServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("SISPU");
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Parse and validate input
            int studentId = Integer.parseInt(req.getParameter("studentId"));
            int subjectId = Integer.parseInt(req.getParameter("subjectId"));
            double score1 = Double.parseDouble(req.getParameter("score1"));
            double score2 = Double.parseDouble(req.getParameter("score2"));

            // Validate score range (e.g., 0 to 10)
            if (score1 < 0 || score1 > 10 || score2 < 0 || score2 > 10) {
                throw new ServletException("Scores must be between 0 and 10");
            }

            EntityManager em = emf.createEntityManager();
            try {
                Student student = em.find(Student.class, studentId);
                Subject subject = em.find(Subject.class, subjectId);

                if (student == null || subject == null) {
                    throw new ServletException("Invalid student or subject ID");
                }

                StudentScore ss = new StudentScore();
                ss.setStudent(student);
                ss.setSubject(subject);
                ss.setScore1(score1);
                ss.setScore2(score2);

                em.getTransaction().begin();
                em.persist(ss);
                em.getTransaction().commit();
            } finally {
                em.close();
            }

            resp.sendRedirect("index");
        } catch (NumberFormatException e) {
            throw new ServletException("Invalid input format", e);
        }
    }
}