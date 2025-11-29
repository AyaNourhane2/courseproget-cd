from django.contrib import admin
from django.urls import path, include
from django.http import JsonResponse

def home(request):
    return JsonResponse({
        "message": "Course Management API is running!",
        "status": "active", 
        "database": "PostgreSQL Render",
        "endpoints": {
            "courses": "/api/courses/",
            "admin": "/admin/",
        }
    })

urlpatterns = [
    path('', home, name='home'),
    path('admin/', admin.site.urls),
    path('api/', include('courses.urls')),  # IMPORTANT: 'courses' sans chemin
]