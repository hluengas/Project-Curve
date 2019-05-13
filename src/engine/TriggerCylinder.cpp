#include "TriggerCylinder.h"
#include "ColliderMesh.h"
#include "Collider.h"
#include "PhysicsObject.h"

#include "BoundingBox.h"
#include <glm/glm.hpp>

using namespace glm;

TriggerCylinder::TriggerCylinder(float radius, float length) :
    Collider(vec3(-radius), vec3(radius)), radius(radius)
{
}

void TriggerCylinder::checkCollision(PhysicsObject *owner, PhysicsObject *obj, Collider *col)
{
    col->checkCollision(obj, owner, this);
}

void TriggerCylinder::checkCollision(PhysicsObject *owner, PhysicsObject *obj, ColliderSphere *col)
{
    checkColSphereTriggerCylinder(obj, col, owner, this);
}