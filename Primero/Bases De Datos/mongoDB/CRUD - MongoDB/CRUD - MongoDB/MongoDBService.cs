using MongoDB.Driver;
namespace CRUD___MongoDB
{
    public class MongoDBService
    {
        private readonly IMongoDatabase _database;
        public MongoDBService(string databaseName)
        {
            var client = new MongoClient("mongodb://mongo:mongo@192.168.56.111");
            _database = client.GetDatabase(databaseName);
        }
        public IMongoCollection<User> Users =>
        _database.GetCollection<User>("users");
        public IMongoCollection<Product> Products =>
        _database.GetCollection<Product>("products");
        public IMongoCollection<Order> Orders =>
        _database.GetCollection<Order>("orders");
        public IMongoCollection<Review> Reviews =>
        _database.GetCollection<Review>("reviews");
        public IMongoCollection<Category> Categories =>
        _database.GetCollection<Category>("categories");
    }
}
