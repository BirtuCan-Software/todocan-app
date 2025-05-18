from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView

from todos.models import Todo
from todos.serializers import TodoSerializer

class TodoListCreateView(ListCreateAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer

class TodoRetrieveUpdateDestroyView(RetrieveUpdateDestroyAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer