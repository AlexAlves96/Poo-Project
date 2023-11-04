/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package meusServlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Aqui você pode adicionar a lógica de autenticação
        // Por exemplo, verificar se o usuário e senha são válidos em um banco de dados

        // Se a autenticação for bem-sucedida, redirecione para uma página de boas-vindas
        if (isValidUser(username, password)) {
            response.sendRedirect("welcome.jsp");
        } else {
            // Caso contrário, redirecione de volta para a página de login com uma mensagem de erro
            response.sendRedirect("login.jsp?error=1");
        }
    }

    private boolean isValidUser(String username, String password) {
        // Adicione a lógica de validação do usuário aqui, por exemplo, consultando um banco de dados.
        // Este é apenas um exemplo simples.
        return "usuario".equals(username) && "senha".equals(password);
    }
}
