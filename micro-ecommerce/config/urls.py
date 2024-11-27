from django.conf.urls.static import static
from django.urls import path, include
from my_admin.admin import admin_site
from django.conf import settings
from django.http import JsonResponse

def health_check(request):
    return JsonResponse({"status": "ok"}, status=200)

urlpatterns = [

    path('admin/', admin_site.urls),
    path('', include('core.urls')),
    path("health", health_check),
    
]

if settings.DEBUG:
    urlpatterns = urlpatterns + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)