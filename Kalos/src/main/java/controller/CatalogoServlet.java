package controller;

import java.io.IOException; 
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProdottoBean;
import model.ProdottoDAO;

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProdottoDAO prodDao = new ProdottoDAO();
        ProdottoBean bean = new ProdottoBean();
        String sort = request.getParameter("sort");
        String action = request.getParameter("action");
        String redirectedPage = request.getParameter("page");

        try {
            if(action != null) {
                if(action.equalsIgnoreCase("add")) {
                    bean.setNome(request.getParameter("nome"));
                    bean.setDescrizione(request.getParameter("descrizione"));
                    bean.setIva(request.getParameter("iva"));
                    bean.setPrezzo(Double.parseDouble(request.getParameter("prezzo")));
                    bean.setQuantità(Integer.parseInt(request.getParameter("quantità")));
                    bean.setTipologia(request.getParameter("tipologia"));
                    bean.setImmagine(request.getParameter("img"));
                    bean.setDescrizioneDettagliata(request.getParameter("descDett"));
                    bean.setInVendita(true);
                    prodDao.doSave(bean);
                } else if(action.equalsIgnoreCase("modifica")) {
                    bean.setIdProdotto(Integer.parseInt(request.getParameter("id")));
                    bean.setNome(request.getParameter("nome"));
                    bean.setDescrizione(request.getParameter("descrizione"));
                    bean.setIva(request.getParameter("iva"));
                    bean.setPrezzo(Double.parseDouble(request.getParameter("prezzo")));
                    bean.setQuantità(Integer.parseInt(request.getParameter("quantità")));
                    bean.setTipologia(request.getParameter("tipologia"));
                    bean.setImmagine(request.getParameter("img"));
                    bean.setDescrizioneDettagliata(request.getParameter("descDett"));
                    prodDao.doUpdate(bean);
                } else if(action.equalsIgnoreCase("delete")) {
                    int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
                    prodDao.doDelete(idProdotto);
                }

                request.getSession().removeAttribute("categorie");
            }
        } catch (SQLException e) {
            System.out.println("Error:" + e.getMessage());
        }

        try {
            request.getSession().removeAttribute("products");
            request.getSession().setAttribute("products", prodDao.doRetrieveAll(sort));
        } catch (SQLException e) {
            System.out.println("Error:" + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/" + redirectedPage);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}


