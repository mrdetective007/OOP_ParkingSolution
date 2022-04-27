<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>

<!doctype html>

<html>
<head>

<title>User Dashboard</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/normalize.css@8.0.0/normalize.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pixeden-stroke-7-icon@1.2.3/pe-icon-7-stroke/dist/pe-icon-7-stroke.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.2.0/css/flag-icon.min.css">
<link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
	<%
		if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
	%>
	<jsp:include page="includes/user-sidebar.jsp"></jsp:include>
	<jsp:include page="includes/user-header.jsp"></jsp:include>
	

	<!-- Content -->
	<div class="content">
		<!-- Animated -->
		<div class="animated fadeIn">
			<!-- Widgets  -->
			<div class="row">

				<div class="col-lg-3 col-md-6">
					<%
						int count = 0;
							Connection con = DatabaseConnection.getConnection();
							Statement st = con.createStatement();
							ResultSet rs = st.executeQuery("select count(*) from tblvehicle where status=''");
							while (rs.next()) {
								count = rs.getInt(1);
							}
					%>
					<div class="card">
						<div class="card-body">
							<div class="stat-widget-five">
								<div class="stat-icon dib flat-color-2">
									<i class="pe-7s-car"></i>
								</div>
								<div class="stat-content">
									<div class="text-left dib">
										<div class="stat-text">
											<span class="count"> <%=count%>
											</span>
										</div>
										<div class="stat-heading">My Total Bookings</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6 col-md-6">
					<%
					int ParingSeatCapactiy=0;
					int count_total_vehentries = 0;
					int count_today_vehentries = 0;
				    int out_entries = 0;
						Statement statement = con.createStatement();
						ResultSet resultset = statement.executeQuery("select count(*) from tblvehicle where date(InTime)=CURDATE()");
						while (resultset.next()) {
							count_today_vehentries = resultset.getInt(1);
						}
						ResultSet rst = statement.executeQuery("select count(*) from tblvehicle where date(InTime)=CURDATE() AND status = 'Out'");
						while(rst.next()){
							out_entries=rst.getInt(1);
						}
					    Statement allstmt = con.createStatement();
					    ResultSet allrst = allstmt.executeQuery("select count(*) from tblvehicle");
					    while (allrst.next()) {
						count_total_vehentries = allrst.getInt(1);
					}
						Statement ParingCapactiyStmt = con.createStatement();
						ResultSet ParingCapactiyrst = allstmt.executeQuery("select * from tblparkingseatcapacity");
						while (ParingCapactiyrst.next()) {
						ParingSeatCapactiy = ParingCapactiyrst.getInt(1)- count_today_vehentries + out_entries;
							}
					%>
					<div class="card">
						<div class="card-body">
							<div class="stat-widget-five">
								<div class="stat-icon dib flat-color-4">
									<i class="pe-7s-car"></i>
								</div>
								<div class="stat-content">
									<div class="text-left dib">
										<div class="stat-text">
											<span class="count"> <%=ParingSeatCapactiy%>
											</span>
										</div>
										<div class="stat-heading">Parking Seats Capacity</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			
		</div>
</div>
		
		<div class="clearfix"></div>
		
		<jsp:include page="includes/footer.jsp"></jsp:include>

		
		<%
			} else {
				response.sendRedirect("user-login.jsp");
			}
		%>
	
</body>
</html>
