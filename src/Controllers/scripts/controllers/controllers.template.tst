$Classes([TypeScriptController])[/*
 * TypeWriter generated API controller for $FullName
 */

/* Imported models */
$ImportViewModel
/* Imported controller */
import { Controller } from './controller';

/* Generated class */
const controllerRoute = $Route;

$DocComment[/**
 * $Summary
 * @extends Controller
 */]
export class $Name extends Controller {
$Methods([Route])[$DocComment[
    /**
      * $Summary
      $Parameters[* @param $Name $Description][
      ]
      * @returns {Promise} $Returns
      */]
	public $name($Parameters[
			$name: $Type][,]) {
		const parameters = {$Parameters[
			'$name': $name,]
		};
		const actionRoute = $Route;
		const route = controllerRoute + '/' + actionRoute;

		return this.fetch$HttpMethod<$ReturnType>(route, parameters);
	}][
]
}]
${
	const string NamePrefix = "Name = \"";
	static List<string> UsedViewModels = new List<string> { };
    
	string ImportViewModel(Class klass) {
        var result = "";

        UsedViewModels.Clear();
        UsedViewModels.Add("number");
        UsedViewModels.Add("string");
        UsedViewModels.Add("boolean");

        foreach (var method in klass.Methods)
        {
            result += ImportViewModel(method);
        }

        return result;
    }
    
	string ImportViewModel(Method method) {
        var result = "";
        foreach (var parameter in method.Parameters)
            result += ImportViewModel(parameter);

		var typeName = ReturnType(method).Replace("[]", "");
		if (!UsedViewModels.Contains(typeName))
        {
	    	UsedViewModels.Add(typeName);
            result += $"import {{ {typeName} }} from '../models/{typeName}';\r\n";
        }

        return result;
	}

	string ImportViewModel(Parameter parameter) {
		var typeName = parameter.Type.Name;
		if (UsedViewModels.Contains(typeName))
			return null;

		UsedViewModels.Add(typeName);

		return $"import {{ {typeName} }} from '../models/{typeName}';\r\n";
	}

	string Route(string value){
		if (string.IsNullOrEmpty(value))
			return $"/* Value Name of Route attribute is missing.*/";

		var nameValueIndex = value.IndexOf(NamePrefix);
		if (nameValueIndex < 0)
			return $"/* Value Name of Route attribute is missing.*/";

		var nameValue = value.Substring(NamePrefix.Length);
		return nameValue.Substring(0, nameValue.IndexOf("\""));
	}

	string Route(Class c){
		var routeAttribute = c.Attributes.FirstOrDefault(a => a.Name == "Route");
		if (routeAttribute == null)
			return $"/* Class {c.Name} does not have attribute RoutePrefix.*/";

        return $"'{routeAttribute.Value}'";
	}

	string Route(Method method){
		var routeAttribute = method.Attributes.FirstOrDefault(a => a.Name == "Route");
		if (routeAttribute == null)
			return $"/* Method {method.Name} does not have attribute Route.*/";

        return $"'{routeAttribute.Value}'";
		// return Route(routeAttribute.Value);
	}

	const string ActionSelectorAttributePrefix = "Http";
	string HttpMethod(Method method){
		var actionAttribute = method.Attributes.FirstOrDefault(a => a.Name.StartsWith(ActionSelectorAttributePrefix));
		if (actionAttribute == null)
			return $"/* Method {method.Name} does not have action selector attribute.*/";

		return actionAttribute.Name.Substring(ActionSelectorAttributePrefix.Length);
	}

    string ReturnType(Method method){
        var isDerivedFromJsonResult = method.Type.BaseClass.Name == "JsonResult";
        var hasSingleTypeParameter = method.Type.TypeArguments.Count == 1;
        if (method.Type.IsGeneric && isDerivedFromJsonResult && hasSingleTypeParameter)
            return method.Type.TypeArguments.Single().Name;
        
        return method.Type.Name;
    }
}