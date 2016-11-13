using Microsoft.AspNetCore.Mvc;

namespace Controllers
{
    public class JsonResult<T> : JsonResult
    {
		public JsonResult(T value)
			: base(value)
		{
			Value = value;
		}

        public new T Value { get; set; }
    }
}