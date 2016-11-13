/// <reference path="../../typings/index.d.ts" />

import 'es6-promise';
const fetch = window.fetch;

import { compileUrl, Parameters } from 'asp-net-core-url-compiler';

type HttpMethod = "get" | "post" | "put";

export abstract class Controller {
    private fetch(
        method: HttpMethod,
        url: string,
        body?: any
    ): Promise<Response> {
        let request: RequestInit = {};

        request.body = body != null
            ? JSON.stringify(body)
            : undefined;
        request.method = method;

        return fetch(url, request);
    }

    protected fetchGet<TResponse>(
        url: string,
        parameters: Parameters
    ): Promise<TResponse> {
        url = compileUrl(url, parameters);
        return this.fetch("get", url)
			.then(r => r.json())
			.then(r => r as TResponse);
    }

    protected fetchPost<TResponse>(
        url: string,
        parameters: any
    ): Promise<TResponse> {
        return this.fetch("post", url, parameters)
			.then(r => r.json())
			.then(r => r as TResponse);
    }
}
