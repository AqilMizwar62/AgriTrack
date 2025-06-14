<!DOCTYPE html>
<html>
<head>
    <title>Harvest Scheduling - AgriTrack</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .harvest-card {
            border-left: 4px solid #28a745;
        }
        .season-badge {
            font-size: 0.8rem;
        }
        .refresh-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        .action-icon-btn {
            width: 32px;
            height: 32px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0;
            border-radius: 0.25rem;
            border: 1px solid;
        }
        .action-icon-btn.btn-outline-primary {
            color: #0d6efd;
            border-color: #0d6efd;
            background-color: transparent;
        }
        .action-icon-btn.btn-outline-primary:hover {
            color: #fff;
            background-color: #0d6efd;
        }
        .action-icon-btn.btn-outline-danger {
            color: #dc3545;
            border-color: #dc3545;
            background-color: transparent;
        }
        .action-icon-btn.btn-outline-danger:hover {
            color: #fff;
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="dashboard.jsp">
                <i class="fas fa-seedling me-2"></i>AgriTrack
            </a>
            <div class="navbar-nav">
                <a class="nav-link" href="dashboard.jsp"><i class="fas fa-home me-1"></i> Dashboard</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2><i class="fas fa-calendar-alt me-2"></i>Harvest Scheduling</h2>
        
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>
        <c:if test="${not empty info}">
            <div class="alert alert-info alert-dismissible fade show">
                ${info}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="info" scope="request"/>
        </c:if>

        <div class="card harvest-card mt-4">
            <div class="card-header bg-success text-white">
                <h4><i class="fas fa-plus-circle me-2"></i>New Harvest Plan</h4>
            </div>
            <div class="card-body">
                <form action="harvest" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Select Crop</label>
                            <select name="cropId" class="form-select" required>
                                <c:forEach items="${crops}" var="crop">
                                    <option value="${crop.cropId}">
                                        ${crop.cropName} (Planted: ${crop.plantingDate})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Harvest Date</label>
                            <input type="date" name="harvestDate" class="form-control" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Season Type</label>
                        <div class="d-flex gap-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="seasonType" 
                                       id="drySeason" value="Dry" checked>
                                <label class="form-check-label" for="drySeason">
                                    Dry Season
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="seasonType" 
                                       id="wetSeason" value="Wet">
                                <label class="form-check-label" for="wetSeason">
                                    Wet Season
                                </label>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-calendar-plus me-1"></i> Schedule Harvest
                    </button>
                </form>
            </div>
        </div>

        <div class="card harvest-card mt-4">
            <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0"><i class="fas fa-list-ol me-2"></i>Upcoming Harvests</h4>
                <form action="harvest" method="get">
                    <button type="submit" class="btn btn-light btn-sm refresh-btn">
                        <i class="fas fa-sync-alt me-1"></i> Refresh
                    </button>
                </form>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty harvestPlans}">
                        <div class="alert alert-info">
                            No harvest plans found.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead class="table-success">
                                    <tr>
                                        <th>Crop</th>
                                        <th>Planted On</th>
                                        <th>Harvest Date</th>
                                        <th>Season</th>
                                        <th>Days Remaining</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${harvestPlans}" var="plan">
                                        <tr>
                                            <td>${plan.cropName}</td>
                                            <td>${plan.plantingDate}</td>
                                            <td>${plan.harvestDate}</td>
                                            <td>
                                                <span class="badge 
                                                    ${plan.seasonType == 'Dry' ? 'bg-warning' : 'bg-info'} 
                                                    season-badge">
                                                    ${plan.seasonType} Season
                                                </span>
                                            </td>
                                            <td>${plan.daysRemaining}</td>
                                            <td>
                                                <button type="button" class="action-icon-btn btn-outline-primary me-1 edit-btn"
                                                        data-bs-toggle="modal" data-bs-target="#editHarvestModal"
                                                        data-plan-id="${plan.planId}"
                                                        data-crop-name="${plan.cropName}"
                                                        data-planting-date="${plan.plantingDate}"
                                                        data-harvest-date="${plan.harvestDate}"
                                                        data-season-type="${plan.seasonType}">
                                                    <i class="fas fa-edit"></i> 
                                                </button>
                                                <form action="harvest" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this harvest plan?');">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="planId" value="${plan.planId}">
                                                    <button type="submit" class="action-icon-btn btn-outline-danger">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
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

    <div class="modal fade" id="editHarvestModal" tabindex="-1" aria-labelledby="editHarvestModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="editHarvestModalLabel"><i class="fas fa-edit me-2"></i>Edit Harvest Plan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="harvest" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="planId" id="editPlanId">
                        
                        <div class="mb-3">
                            <label class="form-label">Crop Name</label>
                            <input type="text" class="form-control" id="editCropName" readonly>
                            <small class="form-text text-muted">Crop cannot be changed after scheduling.</small>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Planting Date</label>
                            <input type="text" class="form-control" id="editPlantingDate" readonly>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Harvest Date</label>
                            <input type="date" name="harvestDate" class="form-control" id="editHarvestDate" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Season Type</label>
                            <div class="d-flex gap-2">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="seasonType" 
                                           id="editDrySeason" value="Dry">
                                    <label class="form-check-label" for="editDrySeason">
                                        Dry Season
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="seasonType" 
                                           id="editWetSeason" value="Wet">
                                    <label class="form-check-label" for="editWetSeason">
                                        Wet Season
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save me-1"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.querySelector('input[type="date"]').min = new Date().toISOString().split('T')[0];
        
        document.querySelectorAll('.season-badge').forEach(badge => {
            badge.classList.add('text-white', 'rounded-pill', 'px-2');
        });

        document.querySelector('.card-header form').addEventListener('submit', function() {
            const button = this.querySelector('button');
            button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...';
            button.disabled = true;
        });

        const editHarvestModal = document.getElementById('editHarvestModal');
        editHarvestModal.addEventListener('show.bs.modal', event => {
            const button = event.relatedTarget;
            const planId = button.getAttribute('data-plan-id');
            const cropName = button.getAttribute('data-crop-name');
            const plantingDate = button.getAttribute('data-planting-date');
            const harvestDate = button.getAttribute('data-harvest-date');
            const seasonType = button.getAttribute('data-season-type');

            const modalTitle = editHarvestModal.querySelector('.modal-title');
            const editPlanIdInput = editHarvestModal.querySelector('#editPlanId');
            const editCropNameInput = editHarvestModal.querySelector('#editCropName');
            const editPlantingDateInput = editHarvestModal.querySelector('#editPlantingDate');
            const editHarvestDateInput = editHarvestModal.querySelector('#editHarvestDate');
            const editDrySeasonRadio = editHarvestModal.querySelector('#editDrySeason');
            const editWetSeasonRadio = editHarvestModal.querySelector('#editWetSeason');

            modalTitle.textContent = `Edit Harvest Plan for ${cropName}`;
            editPlanIdInput.value = planId;
            editCropNameInput.value = cropName;
            editPlantingDateInput.value = plantingDate;
            editHarvestDateInput.value = harvestDate;

            if (seasonType === 'Dry') {
                editDrySeasonRadio.checked = true;
            } else {
                editWetSeasonRadio.checked = true;
            }
            
            editHarvestDateInput.min = new Date().toISOString().split('T')[0];
        });
    </script>
</body>
</html>