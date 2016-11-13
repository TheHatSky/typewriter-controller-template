import { ProductsController } from './controllers/ProductsController';

let products = new ProductsController()
	.getAllProducts(1, 2)
	.then(products => document.write(products[1].name));
