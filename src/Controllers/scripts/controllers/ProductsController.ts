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
