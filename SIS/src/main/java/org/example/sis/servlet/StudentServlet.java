package org.example.sis.servlet;

import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.example.sis.entity.Student;
import org.example.sis.entity.StudentScore;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "StudentServlet", urlPatterns = {"/", "/index"})
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

    // Handle POST requests to add a new student
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("studentCode");
        String name = req.getParameter("fullName");
        String address = req.getParameter("address");

        // Basic input validation
        if (code == null || name == null || address == null || code.trim().isEmpty() || name.trim().isEmpty()) {
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