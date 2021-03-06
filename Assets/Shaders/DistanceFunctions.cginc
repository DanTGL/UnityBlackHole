float SDFSphere(float3 worldPos, float3 rayPos, float radius);
float SDFCylinder(float3 worldPos, float3 rayPos);

float SDFBlackHole(float3 worldPos, float3 rayPos, inout Ray ray) {
    float3 heading = worldPos - rayPos;
    float dist = length(heading);
    float deflection = 2 * 1.0f / dist;
    ray.direction = lerp(ray.direction, normalize(heading), deflection);

    return dist - 1.0f;
}

float SDFDisk(float3 worldPos, float3 rayPos) {
    return max(SDFCylinder(worldPos, rayPos), (SDFSphere(worldPos, rayPos, 0.5f)) * -1);
}

// The MIT License
// Copyright © 2013 Inigo Quilez
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// A list of useful distance function to simple primitives. All
// these functions (except for ellipsoid) return an exact
// euclidean distance, meaning they produce a better SDF than
// what you'd get if you were constructing them from boolean
// operations.
//
// More info here:
//
// https://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm

float SDFSphere(float3 worldPos, float3 rayPos, float radius) {
    return length(worldPos - rayPos) - radius;
}

float SDFCuboid(float3 worldPos, float3 rayPos) {
    float3 offset = abs(worldPos - rayPos) - float3(1.0f, 1.0f, 1.0f);

    return length(max(offset, 0.0)) + min(max(offset.x, max(offset.y, offset.z)), 0.0);
}

float SDFCylinder(float3 worldPos, float3 rayPos) {
    float2 d = abs(float2(length(worldPos.xz - rayPos.xz), worldPos.y - rayPos.y)) - float2(1.0f, 1.0f);
    return min(max(d.x, d.y), 0.0) + length(max(d, 0.0));
}