<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Equipment Tracking - AgriTrack</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .equipment-card {
            border-left: 4px solid #198754;
            transition: transform 0.2s;
        }
        .equipment-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(25, 135, 84, 0.1);
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 4px 10px;
            border-radius: 12px;
        }
        .maintenance-alert {
            border-left: 4px solid #ffc107;
            background-color: #fff8e1;
        }
        .health-meter {
            height: 20px;
            background: #f0f0f0;
            border-radius: 10px;
            overflow: hidden;
        }
        .health-bar {
            height: 100%;
            display: inline-block;
        }
        .refresh-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="dashboard.jsp">
                <i class="fas fa-tractor me-2"></i>AgriTrack
            </a>
            <div class="navbar-nav">
                <a class="nav-link" href="dashboard.jsp"><i class="fas fa-home me-1"></i> Dashboard</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2><i class="fas fa-tools me-2"></i>Equipment Management</h2>
        
        <%-- Messages --%>
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <%-- Equipment Health Dashboard --%>
        <div class="row mt-4">
            <div class="col-md-6">
                <div class="card equipment-card mb-4">
                    <div class="card-header bg-success text-white">
                        <h4><i class="fas fa-heartbeat me-2"></i>Equipment Health</h4>
                    </div>
                    <div class="card-body">
                        <div class="health-meter mb-3">
                            <div class="health-bar bg-success" style="width: ${healthStats['Excellent'] / equipmentList.size() * 100}%"></div>
                            <div class="health-bar bg-primary" style="width: ${healthStats['Good'] / equipmentList.size() * 100}%"></div>
                            <div class="health-bar bg-warning" style="width: ${(healthStats['Needs Maintenance'] + healthStats['Out of Service']) / equipmentList.size() * 100}%"></div>
                        </div>
                        <div class="d-flex justify-content-between text-center">
                            <div>
                                <span class="badge bg-success">Excellent</span>
                                <div class="fw-bold mt-1">${healthStats['Excellent']}</div>
                            </div>
                            <div>
                                <span class="badge bg-primary">Good</span>
                                <div class="fw-bold mt-1">${healthStats['Good']}</div>
                            </div>
                            <div>
                                <span class="badge bg-warning">Needs Attention</span>
                                <div class="fw-bold mt-1">${healthStats['Needs Maintenance'] + healthStats['Out of Service']}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card equipment-card mb-4">
                    <div class="card-header bg-success text-white">
                        <h4><i class="fas fa-calendar-exclamation me-2"></i>Maintenance Alerts</h4>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${maintenanceAlerts}" var="alert">
                            <div class="maintenance-alert p-3 mb-2 rounded">
                                <i class="fas fa-tools me-2"></i>
                                <strong>${alert.name}</strong> needs maintenance by 
                                <strong><fmt:formatDate value="${alert.nextMaintenance}" pattern="MMM dd"/></strong>
                            </div>
                        </c:forEach>
                        <c:if test="${empty maintenanceAlerts}">
                            <p class="text-muted mb-0"><i class="fas fa-check-circle me-2 text-success"></i>No upcoming maintenance</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <%-- Add Equipment Form --%>
        <div class="card equipment-card mb-4">
            <div class="card-header bg-success text-white">
                <h4><i class="fas fa-plus-circle me-2"></i>Add New Equipment</h4>
            </div>
            <div class="card-body">
                <form action="equipment" method="post">
                    <input type="hidden" name="editId" id="editId">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Equipment Name*</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Type*</label>
                            <select name="equipmentType" class="form-select" required>
                                <option value="Tractor">Tractor</option>
                                <option value="Plow">Plow</option>
                                <option value="Seeder">Seeder</option>
                                <option value="Harvester">Harvester</option>
                                <option value="lorry">Lorry</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Condition*</label>
                            <select name="condition" class="form-select" required>
                                <option value="Excellent">Excellent</option>
                                <option value="Good">Good</option>
                                <option value="Needs Maintenance">Needs Maintenance</option>
                                <option value="Out of Service">Out of Service</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Last Maintenance</label>
                            <input type="date" name="lastMaintenance" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Hours Used</label>
                            <input type="number" name="hoursUsed" class="form-control" min="0">
                        </div>
                        <div class="col-md-12">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save me-1"></i> Save Equipment
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <%-- Equipment List --%>
        <div class="card equipment-card">
            <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0"><i class="fas fa-list me-2"></i>Equipment Inventory</h4>
                <form action="equipment" method="get">
                    <button type="submit" class="btn btn-light btn-sm refresh-btn">
                        <i class="fas fa-sync-alt me-1"></i> Refresh
                    </button>
                </form>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty equipmentList}">
                        <div class="alert alert-info">
                            No equipment found. Click "Refresh" to load data from database.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead class="table-success">
                                    <tr>
                                        <th>Name</th>
                                        <th>Type</th>
                                        <th>Condition</th>
                                        <th>Hours</th>
                                        <th>Last Maintenance</th>
                                        <th>Next Maintenance</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${equipmentList}" var="equip">
                                        <tr>
                                            <td>${equip.name}</td>
                                            <td>${equip.equipmentType}</td>
                                            <td>
                                                <span class="badge status-badge 
                                                    ${equip.conditionStatus == 'Excellent' ? 'bg-success' : 
                                                      equip.conditionStatus == 'Good' ? 'bg-primary' : 
                                                      equip.conditionStatus == 'Needs Maintenance' ? 'bg-warning' : 'bg-danger'}">
                                                    ${equip.conditionStatus}
                                                </span>
                                            </td>
                                            <td>${equip.hoursUsed}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${equip.lastMaintenance != null}">
                                                        <fmt:formatDate value="${equip.lastMaintenance}" pattern="MMM dd, yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not recorded</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${equip.nextMaintenance != null}">
                                                        <fmt:formatDate value="${equip.nextMaintenance}" pattern="MMM dd, yyyy"/>
                                                        <c:set var="now" value="<%= new java.util.Date() %>"/>
                                                        <c:if test="${equip.nextMaintenance.time lt now.time}">
                                                            <span class="badge bg-danger ms-2">Overdue!</span>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not scheduled</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <button class="btn btn-sm btn-outline-primary edit-btn" 
                                                            data-id="${equip.id}"
                                                            data-name="${equip.name}"
                                                            data-type="${equip.equipmentType}"
                                                            data-condition="${equip.conditionStatus}"
                                                            data-hours="${equip.hoursUsed}"
                                                            data-last-maintenance="<fmt:formatDate value="${equip.lastMaintenance}" pattern="yyyy-MM-dd"/>">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger delete-btn" data-id="${equip.id}">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.querySelectorAll('.edit-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const id = this.getAttribute('data-id');
                const name = this.getAttribute('data-name');
                const type = this.getAttribute('data-type');
                const condition = this.getAttribute('data-condition');
                const hours = this.getAttribute('data-hours');
                const lastMaintenance = this.getAttribute('data-last-maintenance');
                
                document.getElementById('editId').value = id;
                document.querySelector('input[name="name"]').value = name;
                document.querySelector('select[name="equipmentType"]').value = type;
                document.querySelector('select[name="condition"]').value = condition;
                document.querySelector('input[name="hoursUsed"]').value = hours;
                document.querySelector('input[name="lastMaintenance"]').value = lastMaintenance;
                
                document.querySelector('input[name="name"]').scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
        
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                if (confirm('Are you sure you want to delete this equipment?')) {
                    const id = this.getAttribute('data-id');
                    fetch('equipment?id=' + id, {
                        method: 'DELETE'
                    }).then(response => {
                        if (response.ok) {
                            location.reload();
                        } else {
                            alert('Failed to delete equipment');
                        }
                    });
                }
            });
        });
        
        document.querySelector('input[name="lastMaintenance"]').addEventListener('change', function() {
            if (this.value) {
                const lastDate = new Date(this.value);
                const nextDate = new Date(lastDate);
                nextDate.setMonth(nextDate.getMonth() + 3);
                
                // In a real app, you would set this to a nextMaintenance field
                console.log('Suggested next maintenance:', nextDate.toISOString().split('T')[0]);
            }
        });

        document.querySelector('.card-header form').addEventListener('submit', function() {
            const button = this.querySelector('button');
            button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...';
            button.disabled = true;
        });
    </script>
</body>
</html>