select * from appointments;

select AppointmentID, concat (p.firstname,' ',p.lastname) as Patientname,status,doctorID
from appointments a
join patients p on a.PatientID=p.PatientID
where status="completed";