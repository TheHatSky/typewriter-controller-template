### Before all
This is not production-ready solution. We still can't run it in CI pipeline. But hey, [frhagn](https://github.com/frhagn) is working on it [here](https://github.com/frhagn/Typewriter/issues/133#issuecomment-253746257).

# [Typewriter](http://frhagn.github.io/Typewriter/) template: controller & models
A useful typescript controllers and models generator template based on [Typewriter](http://frhagn.github.io/Typewriter/).

This template provides:
* Controller generation (based on promises)
* Model generation (declares interface from properties with `{ get; set; }`)
* Automatic models import
* Automatic JsDoc generation

### How to use
1. Install Typewriter
1. Clone this repo
1. Investigate `src/controllers/scripts/models/models.template.tst` and `src/controllers/scripts/controllers/controllers.template.tst`
1. Make some changes to `Products.cs` and check how ts-model `Products.ts` has changed
1. Make some changes to `ProductsController.cs` and check how ts-controller `ProductsController.ts` has changed
1. Copy what you think is useful to your project
1. ???
1. PROFIT

### Not supported yet
* HttpGet/HttpPost/etc. based routing. Now it's working only with [Route('smthng')] attribute
* Only GET and POST routes are supported
* Referencing generated models from other projects
* ... and so on


### Exapmle
Based on `TypeScriptViewModel` and `TypeScriptController` attributes these two classes will we be transformed:

```csharp
namespace Controllers.Models
{
    [TypeScriptViewModel]
    public class Product
    {
        public string Name { get; set; }
        public string SystemName { get; set; }
    }
}
```

```csharp
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
    }
}
```

And the output of generation will be:

```typescript
// TypeWriter generated
export interface Product { 
    name: string;
    systemName: string;
}
```

```typescript
/*
 * TypeWriter generated API controller for Controllers.ProductsController
 */

/* Imported models */
import { Product } from '../models/Product';

/* Imported controller */
import { Controller } from './controller';

/* Generated class */
const controllerRoute = 'products';

/**
 * API controller that provides product information and update endpoints.
 * @extends Controller
 */
export class ProductsController extends Controller {

    /**
      * Get data page from list of all products.
      * @param page Pagination page.
      * @param limit Pagination limit per page.
      * @returns {Promise} A page of products.
      */
	public getAllProducts(
			page: number,
			limit: number) {
		const parameters = {
			'page': page,
			'limit': limit,
		};
		const actionRoute = 'all/{limit}/{page}';
		const route = controllerRoute + '/' + actionRoute;

		return this.fetchGet<Product[]>(route, parameters);
	}

    /**
      * Update given product.
      * @param product New product data.
      * @returns {Promise} State of transaction.
      */
	public updateProduct(
			product: Product) {
		const parameters = {
			'product': product,
		};
		const actionRoute = 'update';
		const route = controllerRoute + '/' + actionRoute;

		return this.fetchPost<Product[]>(route, parameters);
	}
}
```

