using MongoDB.Bson;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CRUD___MongoDB
{
    public class Program
    {
        private static async Task Main(string[] args)
        {
            var mongoDBService = new MongoDBService("ecommerce");



            // Crear y agregar usuarios
            var newUser1 = new User
            {
                Name = "John Doe",
                Email = "john.doe@example.com",
                Password = "hashed_password",
                Address = new Address
                {
                    Street = "123 Main St",
                    City = "Springfield",
                    State = "IL",
                    Zip = "62701",
                    Country = "USA"
                },
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };

            var newUser2 = new User
            {
                Name = "Jane Smith",
                Email = "jane.smith@example.com",
                Password = "hashed_password",
                Address = new Address
                {
                    Street = "456 Oak St",
                    City = "Metropolis",
                    State = "NY",
                    Zip = "10001",
                    Country = "USA"
                },
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            await mongoDBService.Users.InsertOneAsync(newUser1);
            await mongoDBService.Users.InsertOneAsync(newUser2);


            // Crear y agregar categorías
            var category1 = new Category
            {
                Name = "Electronics",
                Description = "Devices and gadgets",
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            var category2 = new Category
            {
                Name = "Books",
                Description = "Printed and digital books",
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            await mongoDBService.Categories.InsertOneAsync(category1);
            await mongoDBService.Categories.InsertOneAsync(category2);


            // Crear y agregar productos
            var product1 = new Product
            {
                Name = "Smartphone XYZ",
                Description = "A high-end smartphone with a great camera.",
                Price = 699.99M,
                CategoryId = category1.Id,
                Stock = 100,
                Images = new List<string> { "image1.jpg", "image2.jpg" },
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            var product2 = new Product
            {
                Name = "E-Book Reader",
                Description = "A lightweight e-reader with a sharp display.",
                Price = 129.99M,
                CategoryId = category1.Id,
                Stock = 50,
                Images = new List<string> { "image1.jpg", "image2.jpg" },
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            await mongoDBService.Products.InsertOneAsync(product1);
            await mongoDBService.Products.InsertOneAsync(product2);


            // Crear y agregar pedidos
            var order1 = new Order
            {
                UserId = newUser1.Id,
                Products = new List<OrderProduct>
                {
                new OrderProduct { ProductId = product1.Id, Quantity = 1, Price =
                product1.Price },
                new OrderProduct { ProductId = product2.Id, Quantity = 1, Price =
                product2.Price }
                },
                Total = product1.Price + product2.Price,
                Status = "Processing",
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            await mongoDBService.Orders.InsertOneAsync(order1);


            // Crear y agregar reseñas
            var review1 = new Review
            {
                ProductId = product1.Id,
                UserId = newUser1.Id,
                Rating = 4.5,
                Comment = "Great phone, but the battery life could be better.",
                CreatedAt = DateTime.UtcNow
            };
            var review2 = new Review
            {
                ProductId = product2.Id,
                UserId = newUser2.Id,
                Rating = 5,
                Comment = "Love this e-reader, it's very convenient.",
                CreatedAt = DateTime.UtcNow
            };
            await mongoDBService.Reviews.InsertOneAsync(review1);
            await mongoDBService.Reviews.InsertOneAsync(review2);




            // Consultas avanzadas
            // 1. Obtener todos los productos de una categoría específica
            var electronicsCategoryId = category1.Id;
            var electronicsProducts = await mongoDBService.Products.Find(p =>
            p.CategoryId == electronicsCategoryId).ToListAsync();
            Console.WriteLine("Productos en la categoría de Electronics:");
            foreach (var product in electronicsProducts)
            {
                Console.WriteLine($"- {product.Name}: ${product.Price}");
            }


            // 2. Obtener todas las órdenes de un usuario específico
            var userId = newUser1.Id;
            var userOrders = await mongoDBService.Orders.Find(o => o.UserId ==
            userId).ToListAsync();
            Console.WriteLine($"Órdenes del usuario {newUser1.Name}:");
            foreach (var order in userOrders)
            {
                Console.WriteLine($"- Orden ID: {order.Id}, Total: ${order.Total}, Estado: { order.Status} ");
            }


            // 3. Obtener todas las reseñas de un producto específico
            var productId = product1.Id;
            var productReviews = await mongoDBService.Reviews.Find(r => r.ProductId
            == productId).ToListAsync();
            Console.WriteLine($"Reseñas del producto {product1.Name}:");
            foreach (var review in productReviews)
            {
                var user = await mongoDBService.Users.Find(u => u.Id ==
                review.UserId).FirstOrDefaultAsync();
                Console.WriteLine($"- {user.Name} (Rating: {review.Rating}): { review.Comment}");
            }


            // 4. Actualizar la cantidad de stock de un producto
            var updateStockDefinition = Builders<Product>.Update.Set(p => p.Stock,
            200);
            await mongoDBService.Products.UpdateOneAsync(p => p.Id == product1.Id,
            updateStockDefinition);
            Console.WriteLine($"Stock del producto {product1.Name} actualizado.");


            // 5. Eliminar una categoría y sus productos asociados
            var categoryToDelete = category2.Id;
            await mongoDBService.Products.DeleteManyAsync(p => p.CategoryId ==
            categoryToDelete);
            await mongoDBService.Categories.DeleteOneAsync(c => c.Id ==
            categoryToDelete);
            Console.WriteLine($"Categoría {category2.Name} y sus productos asociados eliminados.");



        }
    }
}
