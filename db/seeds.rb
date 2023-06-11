# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Crear usuarios de ejemplo
User.create(email: 'usuario1@example.com', password: 'password1', role: 1, name: 'Usuario 1', age: '25')
User.create(email: 'usuario2@example.com', password: 'password2', role: 2, name: 'Usuario 2', age: '30')
User.create(email: 'invitado@tudominio.com', password: 'password', role: 0, name:'Invitado', age:'0')

# Agrega más usuarios si es necesario

# Crear noticias de ejemplo asociadas a un usuario
user1 = User.first
user2 = User.second
user1.news.create(title: 'Noticia 1', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing elit pellentesque habitant morbi tristique senectus et netus et. Pulvinar mattis nunc sed blandit libero volutpat sed cras. Ultrices neque ornare aenean euismod elementum nisi quis eleifend.')
user2.news.create(title: 'Noticia 2', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eget duis at tellus at urna condimentum mattis pellentesque. Convallis tellus id interdum velit laoreet id donec ultrices. Dignissim diam quis enim lobortis scelerisque fermentum.')
# Agrega más noticias si es necesario

# Crear comentarios de ejemplo asociados a una noticia y un usuario
news1 = News.first
news2 = News.second
user1.comments.create(content: 'viverra vitae congue eu consequat ac felis donec et odio', news: news1)
user2.comments.create(content: 'euismod in pellentesque massa placerat duis ultricies lacus sed turpis', news: news2)
# Agrega más comentarios si es necesario
