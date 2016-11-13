using Microsoft.AspNetCore.Mvc;
using Controllers.Models;

namespace Controllers
{
	/// <summary>
	/// API controller that provides product information and update endpoints.
	/// </summary>
    [TypeScriptController]
    [Route("products")]
	public class ProductsController : Controller
    {
		/// <summary>
		/// Get data page from list of all products.
		/// </summary>
		///	<param name="page">Pagination page.</param>
		///	<param name="limit">Pagination limit per page.</param>
		///	<returns>A page of products.</returns>
		[HttpGet, Route("all/{limit}/{page}")]

        public JsonResult<Product[]> GetAllProducts(int page, int limit)
        {
			var result = new Product[]
				{
					new Product
					{
						Name = "Abba"
					},
					new Product
					{
						Name = "Cabba"
					},
				};

			return new JsonResult<Product[]>(result);
        }

		/// <summary>
		/// Update given product.
		/// </summary>
		///	<param name="product">New product data.</param>
		///	<returns>State of transaction.</returns>
		[HttpPost, Route("update")]
        public JsonResult<Product[]> UpdateProduct(Product product)
        {
			var result = new Product[]
				{
					new Product
					{
						Name = "Abba"
					},
					new Product
					{
						Name = "Cabba"                                                                                                                             ,
					},
				};

			return new JsonResult<Product[]>(result);
        }
    }
}