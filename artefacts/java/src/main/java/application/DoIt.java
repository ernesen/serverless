package application;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.RequestDispatcher;
import java.util.Base64;

@WebServlet(urlPatterns = "/doit")
public class DoIt extends HttpServlet {
        private static final long serialVersionUID = 1L;

        /**
         * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
         *      response)
         */
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                response.setContentType("application/json");
                response.getWriter().append("{\"status\":\"UP\"}");
                response.setStatus(response.SC_OK);
        }

        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                System.out.println(request.getParameter("name"));
                System.out.println(request.getParameter("emailId"));
				System.out.println(request.getParameter("text"));

                URL myurl = null;
                myurl = new URL("https://us-south.functions.cloud.ibm.com/api/v1/namespaces/ernese%40sg.ibm.com_cloudnative-dev/actions/Bluemix_testdb_theKey/create-document?blocking=true");

                String username = "74476abb-312a-4226-9d7c-f1f0ae645255";
                String password = "2UuYA49AudKNkuRpSJWDYsBAiZ84jl8q4vYuLcZU1hzyQwoNTK33tPQMnp0cDbPj";
                String encoded = Base64.getEncoder()
                                .encodeToString((username + ":" + password).getBytes(StandardCharsets.UTF_8)); // Java 8
                //System.out.println(encoded);
                HttpsURLConnection con = (HttpsURLConnection) myurl.openConnection();
                con.setRequestMethod("POST");
                con.setRequestProperty("Content-Type", "application/json");
                con.setRequestProperty("Authorization", "Basic " + encoded);
                con.setDoOutput(true);
                con.setDoInput(true);

                DataOutputStream output = new DataOutputStream(con.getOutputStream());
                JsonObject doc = Json.createObjectBuilder().add("name", request.getParameter("name"))
                                .add("emailId", request.getParameter("emailId"))
                                .add("_id", request.getParameter("emailId"))
								.add("text", request.getParameter("text")).build();

                JsonObject json = Json.createObjectBuilder().add("dbname", "testdb").add("doc", doc)
                                .add("docId", request.getParameter("emailId")).build();

                System.out.println(json.toString());
                output.writeBytes(json.toString());

                output.close();

                DataInputStream input = new DataInputStream(con.getInputStream());
                input.close();

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.html");
                dispatcher.forward(request, response);

        }

}
