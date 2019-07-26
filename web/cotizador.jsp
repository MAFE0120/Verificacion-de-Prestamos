<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="modelo.vo.Socio"%>
<%@page import="control.SocioControl"%>
<%@page import="modelo.conexion.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="vista/css/EstiloMenu.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <title>Financiamiento S.A.S</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link titulo">Financiamiento S.A.S</a>
                    </li>
                </ul>
                <ul class="navbar-nav form-inline my-2 my-lg-0">
                    <li class="nav-item">
                        <a class="nav-link off mr-2" href="cerrarsesion.jsp">Cerrar sesion <i class="fas fa-power-off"></i></a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container">
            <h1 class="text-center">COTIZADOR</h1>

            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="display:none;" id="fallo">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <strong>NO</strong> hay socio disponible
            </div>  
            <%                
                HttpSession sesion = request.getSession();
                String contextPath = request.getContextPath();
                response.setHeader("Cache-Control", "no-store,no-cache, must-revalidate");
                response.addHeader("Cache-Control", "post-check=0, pre-check=0");
                response.setHeader("Pragma", "no-cache");
                response.setHeader("Expires", "0");
                
                DecimalFormat formatea = new DecimalFormat("###,###.##");
                Connection cnn = Conexion.getConexionDB();
                SocioControl scontrol = new SocioControl(cnn);

                String monto = request.getParameter("monto");

                Socio vo = null;

                int VA = 0, n = 36, total = 0, cuota = 0;
                double i = 0.0, VF = 0.0;
                if (monto != null) {
                    vo = scontrol.socioPrestamista(monto);
                    if (vo != null) {
                        System.out.println(vo);
                        VA = Integer.parseInt(monto);
                        i = Double.parseDouble(vo.getTasa()) / 100;
                        VF = VA * (1 + n * i);
                        total = (int) VF;

                        cuota = total / n;
                    }
                }
            %>


            <form method="post">
                <i class="fas fa-funnel-dollar"></i> <label>Ingrese el monto requerido</label>
                <div class="form-group">
                    <div class="form-inline"> 
                        <input type="text" id="monto" name="monto" placeholder="Ingrese el monto ominitiendo puntos o comas" class="form-control col-sm-4 mr-3">
                        <button class="btn btn-outline-warning">Calcular</button>                      
                    </div>
                </div>

                <table class="table table-bordered table-hover text-center">
                    <thead class="table-info">
                        <tr>
                            <th>Socio que realiza el préstamo</th>
                            <th>Cuota mensual</th>
                            <th>Pago total del credito</th>
                            <th>Tasa de interés mensual</th>
                        </tr>
                    </thead>
                    <tbody id="contenido">
                        <% 
                            if(vo!= null) {
                        %>
                        <tr>
                            <td><%= vo.getNombre_socio()%></td>
                            <td><%= formatea.format(cuota)%></td>
                            <td><i class="fas fa-dollar-sign mr-2"></i><%= formatea.format(total)%></td>
                            <td><%= vo.getTasa()%></td>

                        <%
                            } else {

                        %>
                            <td>Ninguo</td>
                            <td>0</td>
                            <td><i class="fas fa-dollar-sign mr-2"></i>0</td>
                            <td>0</td>
                        </tr>
                            <script type="text/javascript">
                                $("#fallo").show();
                                setTimeout(function () {
                                    $("#fallo").hide();
                                }, 2000);
                            </script>
                        <%                          
                            }
                        %>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>