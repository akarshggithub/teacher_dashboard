function editStudent(id) {
  // Fetch student data and populate modal
  fetch(`/students/${id}`)
    .then(response => response.json())
    .then(student => {
      // Populate modal with student data
      showModal(student);
    });
}

function deleteStudent(id) {
  if (confirm('Are you sure you want to delete this student?')) {
    fetch(`/students/${id}`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    })
    .then(() => {
      // Remove student from the list
      document.querySelector(`tr[data-id="${id}"]`).remove();
    });
  }
}

function showAddModal() {
  showModal();
}

function showModal(student = null) {
  const modal = document.getElementById('studentModal');
  modal.style.display = 'block';
  // Populate modal with form fields
  // If student is provided, fill in the fields for editing
}

function saveStudent() {
  // Get form data
  const formData = new FormData(document.getElementById('studentForm'));
  const method = formData.get('id') ? 'PATCH' : 'POST';
  const url = formData.get('id') ? `/students/${formData.get('id')}` : '/students';

  fetch(url, {
    method: method,
    body: formData,
    headers: {
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    }
  })
  .then(response => response.json())
  .then(student => {
    // Update or add student in the list
    updateStudentList(student);
    closeModal();
  });
}

function updateStudentList(student) {
  // Update or add student row in the table
}

function closeModal() {
  const modal = document.getElementById('studentModal');
  modal.style.display = 'none';
}