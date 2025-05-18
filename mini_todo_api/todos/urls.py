from django.urls import path
from .views import TodoListCreateView, TodoRetrieveUpdateDestroyView

urlpatterns = [
  path('todos/', TodoListCreateView.as_view(), name='todo-list-create'),
  path('todos/<int:pk>/', TodoRetrieveUpdateDestroyView.as_view(), name='todo-detail'),
]