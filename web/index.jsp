<%@page import="modelo.vo.Usuario"%>
<%@page import="control.UsuarioControl"%>
<%@page import="modelo.conexion.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="vista/css/Estilos.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <title>Financiamiento S.A.S</title>
    </head>
    <body>
        <div class="container">
            <div class="col-sm-4 ">
                <div class="alert alert-warning alert-dismissible fade show" role="alert" style="display:none;" id="usuarioInvalido">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <strong>Correo</strong> o <strong>Clave</strong> erroneos verifique, e intentelo de nuevo 
                </div>  

                <%
                    String contextPath = request.getContextPath();
                    response.setHeader("Cache-Control", "no-store,no-cache, must-revalidate");
                    response.addHeader("Cache-Control", "post-check=0, pre-check=0");
                    response.setHeader("Pragma", "no-cache");
                    response.setHeader("Expires", "0");

                    String correo = request.getParameter("correo");
                    String clave = request.getParameter("clave");

                    Connection cnn = Conexion.getConexionDB();
                    Usuario vo = null;
                    if (correo != "" && clave != "" && correo != null && clave != null) {
                        UsuarioControl control = new UsuarioControl(cnn);
                        vo = control.consultarUsuario(correo, clave);
                        if (vo != null) {
                            System.out.println(vo.getClave());
                            if (vo.getFk_estado() == 1) {
                                HttpSession sesion = request.getSession();
                                sesion.setAttribute("usuario", vo);
                                response.sendRedirect(request.getContextPath() + "/cotizador.jsp");
                            }
                        } else {
                            response.sendRedirect(request.getContextPath() + "/index.jsp");
                %>
                <script type="text/javascript">
                    $("#usuarioInvalido").show();
                    setTimeout(function () {
                        $("#usuarioInvalido").hide();
                    }, 2000);
                </script>
                <%
                        }

                    }


                %>

                <div class="container rounded-lg opaco">
                    <form>
                        <h1 class="text-center">Financiamiento S.A.S</h1>
                        <div class="form-group">
                            <label>Correo :</label>
                            <input type="email" id="correo" name="correo" placeholder="Escriba su correo" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Contraseña :</label>
                            <input type="password" id="clave" name="clave" placeholder="Escriba su contraseña" class="form-control" required>
                        </div>                    
                        <button class="btn btn-outline-info btn-lg btn-block">Iniciar Sesión</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
