#pragma once

#include "BoundingBox.h"

#include <glm/glm.hpp>
#include <vector>

#define GLM_ENABLE_EXPERIMENTAL
#include <glm/gtx/hash.hpp>

// https://eli.thegreenplace.net/2016/a-polyglots-guide-to-multiple-dispatch/
// https://gamedevelopment.tutsplus.com/tutorials/how-to-create-a-custom-2d-physics-engine-the-basics-and-impulse-resolution--gamedev-6331

class ColliderMesh;
class ColliderSphere;
class TriggerSphere;
class TriggerCylinder;
class PhysicsObject;

struct Collision {
    PhysicsObject *other;
    float penetration;
    glm::vec3 normal;
};

class Collider
{
public:
    Collider(glm::vec3 min, glm::vec3 max);
    Collider(float radius);

    virtual void checkCollision(PhysicsObject *owner, PhysicsObject *obj, Collider *col) = 0;
    virtual void checkCollision(PhysicsObject *owner, PhysicsObject *obj, ColliderMesh *col) {};
    virtual void checkCollision(PhysicsObject *owner, PhysicsObject *obj, ColliderSphere *col) {};
    virtual void checkCollision(PhysicsObject *owner, PhysicsObject *obj, TriggerSphere *col) {};
    virtual void checkCollision(PhysicsObject *owner, PhysicsObject *obj, TriggerCylinder *col) {};

    BoundingBox bbox;

    std::vector<Collision> pendingCollisions;
};

void checkSphereMesh(PhysicsObject *sphere, ColliderSphere *sphereCol, PhysicsObject *mesh, ColliderMesh *meshCol);
void checkSphereSphere(PhysicsObject *sphere1, ColliderSphere *sphereCol1, PhysicsObject *sphere2, ColliderSphere *sphereCol2);
void checkColSphereTriggerSphere(PhysicsObject *cSphere, ColliderSphere *cSphereCol, PhysicsObject *tSphere, TriggerSphere *tSphereTrig);
void checkColSphereTriggerCylinder(PhysicsObject *sphere, ColliderSphere *sphereCol, PhysicsObject *cylinder, TriggerCylinder *cylinderTrig);


// Used for inserting pairs of vertices into a hash set
struct Edge
{
    glm::vec3 v0, v1;

    Edge(glm::vec3 v0, glm::vec3 v1) : v0(v0), v1(v1)
    {
    }

    bool operator==(const Edge &e) const
    {
        return (v0 == e.v0 && v1 == e.v1) ||
            (v0 == e.v1 && v1 == e.v0);
    }
};

class EdgeHash
{
public:
    size_t operator()(const Edge &e) const
    {
        return std::hash<glm::vec3>()(e.v0) ^ std::hash<glm::vec3>()(e.v1);
    }
};