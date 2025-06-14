<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crop Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 20px;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .crop-image {
            max-width: 100px;
            max-height: 100px;
            object-fit: cover;
            border-radius: 4px;
        }
        .suggest-crop-section {
            padding: 20px 0;
            background-color: #f1f8f1;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        .suggest-crop-section h2 {
            color: #198754;
            font-weight: bold;
            margin-top: 10px;
            margin-bottom: 30px;
            text-align: center;
        }
        .suggest-crop-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(25, 135, 84, 0.08);
            padding: 24px 10px;
            text-align: center;
            transition: box-shadow 0.2s, transform 0.2s;
            margin-bottom: 16px;
            border: 1px solid #e0ece6;
        }
        .suggest-crop-card:hover {
            box-shadow: 0 6px 18px rgba(25, 135, 84, 0.18);
            transform: translateY(-4px);
        }
        .suggest-crop-card img {
            border-radius: 8px;
            margin-bottom: 16px;
            box-shadow: 0 2px 8px rgba(25, 135, 84, 0.10);
            width: 100px;
            height: 100px;
            object-fit: cover;
        }
        .suggest-crop-card h4 {
            color: #146c43;
            font-size: 1.3rem;
            margin-bottom: 12px;
        }
        .suggest-crop-card ul {
            list-style: none;
            padding: 0;
            margin: 0 0 8px 0;
            color: #333;
            font-size: 1rem;
        }
        .suggest-crop-card ul li {
            margin-bottom: 4px;
        }
        .refresh-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container-fluid">
            <a class="navbar-brand" href="dashboard.jsp">
                <i class="fas fa-tractor me-2"></i>AgriTrack
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="dashboard.jsp"><i class="fas fa-home me-1"></i> Dashboard</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <h2>Crop Management</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">${error}</div>
        <% } %>

        <!-- Crop Suggestions Section -->
        <div class="suggest-crop-section">
            <h2>Crop Suggestions</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="suggest-crop-card">
                        <img src="${pageContext.request.contextPath}/img/corn.jpg" alt="Corn">
                        <h4>Corn</h4>
                        <ul>
                            <li>Germination to Vegetative: 7-14 days</li>
                            <li>Vegetative to Flowering: 45-60 days</li>
                            <li>Flowering to Maturity: 50-70 days</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="suggest-crop-card">
                        <img src="${pageContext.request.contextPath}/img/wheat.jpg" alt="Wheat">
                        <h4>Wheat</h4>
                        <ul>
                            <li>Germination to Vegetative: 5-10 days</li>
                            <li>Vegetative to Flowering: 40-60 days</li>
                            <li>Flowering to Maturity: 30-45 days</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="suggest-crop-card">
                        <img src="${pageContext.request.contextPath}/img/rice.webp" alt="Rice">
                        <h4>Rice</h4>
                        <ul>
                            <li>Germination to Vegetative: 7-15 days</li>
                            <li>Vegetative to Flowering: 40-70 days</li>
                            <li>Flowering to Maturity: 30-45 days</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="suggest-crop-card">
                        <img src="${pageContext.request.contextPath}/img/soybeans.jpg" alt="Soybeans">
                        <h4>Soybeans</h4>
                        <ul>
                            <li>Germination to Vegetative: 5-10 days</li>
                            <li>Vegetative to Flowering: 35-45 days</li>
                            <li>Flowering to Maturity: 40-50 days</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="suggest-crop-card">
                        <img src="${pageContext.request.contextPath}/img/potatoes.jpg" alt="Potatoes">
                        <h4>Potatoes</h4>
                        <ul>
                            <li>Germination to Vegetative: 14-28 days</li>
                            <li>Vegetative to Flowering: 30-50 days</li>
                            <li>Flowering to Maturity: 60-90 days</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="suggest-crop-card">
                        <img src="${pageContext.request.contextPath}/img/tomatoes.jpg" alt="Tomatoes">
                        <h4>Tomatoes</h4>
                        <ul>
                            <li>Germination to Vegetative: 7-14 days</li>
                            <li>Vegetative to Flowering: 30-45 days</li>
                            <li>Flowering to Maturity: 45-70 days</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Current Crops Section with Refresh Button -->
        <div class="card mt-4">
            <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0">Current Crops</h4>
                <form action="crops" method="get">
                    <button type="submit" class="btn btn-light btn-sm refresh-btn">
                        <i class="fas fa-sync-alt me-1"></i> Refresh
                    </button>
                </form>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty crops}">
                        <div class="alert alert-info">
                            No crops found. Click "Refresh" to load data from database.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Crop Name</th>
                                    <th>Planting Date</th>
                                    <th>Status</th>
                                    <th>Notes</th>
                                    <th>Photo</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="crop" items="${crops}">
                                    <tr>
                                        <td>${crop.cropName}</td>
                                        <td>${crop.plantingDate}</td>
                                        <td>${crop.status}</td>
                                        <td>${crop.notes}</td>
                                        <td>
                                            <c:if test="${not empty crop.imagePath}">
                                                <img src="${pageContext.request.contextPath}/${crop.imagePath}" alt="Crop Photo" class="crop-image">
                                            </c:if>
                                            <c:if test="${empty crop.imagePath}">
                                                No Photo
                                            </c:if>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editCropModal"
                                                        data-crop-id="${crop.cropId}"
                                                        data-crop-name="${crop.cropName}"
                                                        data-planting-date="${crop.plantingDate}"
                                                        data-status="${crop.status}"
                                                        data-notes="${crop.notes}"
                                                        data-image-path="${crop.imagePath}">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <a href="crops?action=delete&cropId=${crop.cropId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this crop? This will also remove the associated photo.');">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Add New Crop Form -->
        <div class="card mt-4">
            <div class="card-header bg-success text-white">
                <h4>Add New Crop</h4>
            </div>
            <div class="card-body">
                <form action="crops" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label class="form-label">Crop Name</label>
                        <select name="cropName" id="cropNameSelect" class="form-select" required onchange="handleCropNameSelection()">
                            <option value="" disabled selected>Select a crop</option>
                            <option value="Corn">Corn</option>
                            <option value="Wheat">Wheat</option>
                            <option value="Rice">Rice</option>
                            <option value="Soybeans">Soybeans</option>
                            <option value="Potatoes">Potatoes</option>
                            <option value="Tomatoes">Tomatoes</option>
                            <option value="Other">Other (please specify)</option>
                        </select>
                        <div id="otherCropContainer" class="mt-2" style="display: none;">
                            <input type="text" name="otherCropName" id="otherCropName" class="form-control" placeholder="Enter crop name">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Planting Date</label>
                        <input type="date" name="plantingDate" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-select" required>
                            <option value="Germination">Germination</option>
                            <option value="Vegetative">Vegetative</option>
                            <option value="Flowering">Flowering</option>
                            <option value="Maturity">Maturity</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Notes</label>
                        <textarea name="notes" class="form-control"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Crop Photo</label>
                        <input type="file" name="image" class="form-control" accept="image/*">
                    </div>
                    <button type="submit" class="btn btn-success">Add Crop</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Crop Modal -->
    <div class="modal fade" id="editCropModal" tabindex="-1" aria-labelledby="editCropModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editCropModalLabel">Edit Crop</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="crops" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="cropId" id="editCropId">
                    <input type="hidden" name="existingImagePath" id="editExistingImagePath">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Crop Name</label>
                            <select name="cropName" id="editCropNameSelect" class="form-select" required onchange="handleEditCropNameSelection()">
                                <option value="" disabled>Select a crop</option>
                                <option value="Corn">Corn</option>
                                <option value="Wheat">Wheat</option>
                                <option value="Rice">Rice</option>
                                <option value="Soybeans">Soybeans</option>
                                <option value="Potatoes">Potatoes</option>
                                <option value="Tomatoes">Tomatoes</option>
                                <option value="Other">Other (please specify)</option>
                            </select>
                            <div id="editOtherCropContainer" class="mt-2" style="display: none;">
                                <input type="text" name="otherCropName" id="editOtherCropName" class="form-control" placeholder="Enter crop name">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Planting Date</label>
                            <input type="date" name="plantingDate" id="editPlantingDate" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <select name="status" id="editStatus" class="form-select" required>
                                <option value="Germination">Germination</option>
                                <option value="Vegetative">Vegetative</option>
                                <option value="Flowering">Flowering</option>
                                <option value="Maturity">Maturity</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Notes</label>
                            <textarea name="notes" id="editNotes" class="form-control"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Current Crop Photo</label>
                            <div id="currentCropPhotoContainer"></div>
                            <input type="file" name="image" class="form-control mt-2" accept="image/*">
                            <small class="form-text text-muted">Upload a new photo to replace the current one.</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function handleCropNameSelection() {
            const select = document.getElementById('cropNameSelect');
            const otherContainer = document.getElementById('otherCropContainer');
            const otherInput = document.getElementById('otherCropName');
            
            if (select.value === 'Other') {
                otherContainer.style.display = 'block';
                otherInput.setAttribute('required', 'required');
            } else {
                otherContainer.style.display = 'none';
                otherInput.removeAttribute('required');
            }
        }

        function handleEditCropNameSelection() {
            const select = document.getElementById('editCropNameSelect');
            const otherContainer = document.getElementById('editOtherCropContainer');
            const otherInput = document.getElementById('editOtherCropName');
            
            if (select.value === 'Other') {
                otherContainer.style.display = 'block';
                otherInput.setAttribute('required', 'required');
            } else {
                otherContainer.style.display = 'none';
                otherInput.removeAttribute('required');
            }
        }

        var editCropModal = document.getElementById('editCropModal');
        editCropModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var cropId = button.getAttribute('data-crop-id');
            var cropName = button.getAttribute('data-crop-name');
            var plantingDate = button.getAttribute('data-planting-date');
            var status = button.getAttribute('data-status');
            var notes = button.getAttribute('data-notes');
            var imagePath = button.getAttribute('data-image-path');

            var modalCropId = editCropModal.querySelector('#editCropId');
            var modalCropNameSelect = editCropModal.querySelector('#editCropNameSelect');
            var modalPlantingDate = editCropModal.querySelector('#editPlantingDate');
            var modalStatus = editCropModal.querySelector('#editStatus');
            var modalNotes = editCropModal.querySelector('#editNotes');
            var modalExistingImagePath = editCropModal.querySelector('#editExistingImagePath');
            var currentCropPhotoContainer = editCropModal.querySelector('#currentCropPhotoContainer');
            var modalOtherContainer = editCropModal.querySelector('#editOtherCropContainer');
            var modalOtherInput = editCropModal.querySelector('#editOtherCropName');

            modalCropId.value = cropId;
            modalPlantingDate.value = plantingDate;
            modalStatus.value = status;
            modalNotes.value = notes;
            modalExistingImagePath.value = imagePath;

            const isOtherCrop = !['Corn', 'Wheat', 'Rice', 'Soybeans', 'Potatoes', 'Tomatoes'].includes(cropName);
            if (isOtherCrop) {
                modalCropNameSelect.value = 'Other';
                modalOtherContainer.style.display = 'block';
                modalOtherInput.value = cropName;
                modalOtherInput.setAttribute('required', 'required');
            } else {
                modalCropNameSelect.value = cropName;
                modalOtherContainer.style.display = 'none';
                modalOtherInput.removeAttribute('required');
            }

            currentCropPhotoContainer.innerHTML = '';
            if (imagePath && imagePath !== 'null') {
                var img = document.createElement('img');
                img.src = "${pageContext.request.contextPath}/" + imagePath;
                img.alt = "Current Crop Photo";
                img.classList.add('img-thumbnail', 'crop-image');
                currentCropPhotoContainer.appendChild(img);
            } else {
                currentCropPhotoContainer.innerHTML = '<p>No photo uploaded.</p>';
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