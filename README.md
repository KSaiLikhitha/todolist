

```markdown
# **🌟 TodoList App 🌟**

A simple **Todo list** application built with **Node.js**, **Express**, **SQLite**, and deployed on **OpenShift**. This project serves as a **full-stack application**, with a frontend for displaying tasks and a backend for managing tasks through a REST API.

## **🚀 Features**

- **CRUD** operations (Create, Read, Update, Delete) for managing todos.
- **Persistent storage** using **SQLite**.
- **Dockerized** for containerized deployment.
- Deployed on **OpenShift** with **Persistent Volume** for data storage.

## **🛠️ Prerequisites**

Before running this project, make sure you have the following installed:

- 🐳 **Docker** (for local containerization and testing)
- 🌐 **OpenShift CLI** (`oc`)
- 🚀 **Node.js** (v18+)
- 📦 **npm** (or yarn)

## **🗂️ Project Structure**

**```
├── **backend/**                # Backend code (server.js, database, API)
│   ├── **server.js**           # Main backend application logic
│   ├── **todos.db**            # SQLite database for storing todos
│   └── **package.json**        # Node.js dependencies
├── **frontend/**               # Frontend code (HTML, CSS)
│   ├── **index.html**          # Main frontend page
│   └── **styles.css**          # CSS for styling the frontend
├── **Dockerfile**              # Docker configuration for the app
├── **template.yaml**           # OpenShift template for deployment
└── **README.md**               # Project documentation (this file)
```**

## **📝 Setup Instructions**

### **1. Clone the repository**

```bash
git clone https://github.com/your-username/todo-app.git
cd todo-app
```

### **2. Install dependencies**

For the backend:

```bash
cd backend
npm install
```

### **3. Run the application locally**

To run the app locally using Docker:

```bash
docker build -t todo-app .
docker run -p 3333:3333 todo-app
```

Your app should now be accessible at [http://localhost:3333](http://localhost:3333).

### **4. Deploy on OpenShift**

1. Log in to your OpenShift cluster:

```bash
oc login <your-cluster-url> --token=<your-token>
```

2. Apply the OpenShift template to create the necessary resources:

```bash
oc apply -f template.yaml
```

3. Open the route for the app:

```bash
oc get route
```

You should see the URL where your app is running.

## **📦 Persistent Storage**

The app uses a **Persistent Volume (PVC)** to store the `todos.db` file. This ensures that your data is preserved across pod restarts in OpenShift.

## **🧑‍💻 Dockerfile Explanation**

The `Dockerfile` is used to build a container image that runs the Node.js backend. Key steps include:

- Copying **backend** and **frontend** files
- Creating necessary directories (`/app/backend/data`) with the appropriate permissions
- Installing dependencies (`npm install`)
- Exposing port `3333` for the API
- Running the app using `node server.js`

## **🧑‍💻 OpenShift Template**

The `template.yaml` file is an OpenShift template that defines:

- A **PersistentVolumeClaim** for storing the database
- A **Service** to expose the app
- A **DeploymentConfig** for deploying the app on OpenShift

## **💻 API Endpoints**

### **`GET /api/todos`**

Fetches all todos.

#### **Response:**
```json
[
  {
    "id": 1,
    "task": "Sample todo"
  }
]
```

### **`POST /api/todos`**

Adds a new todo.

#### **Request body:**
```json
{
  "task": "New Todo"
}
```

#### **Response:**
```json
{
  "id": 2,
  "task": "New Todo"
}
```

### **`DELETE /api/todos/:id`**

Deletes a todo by its ID.

#### **Example:**
```bash
DELETE /api/todos/1
```

#### **Response:**
`200 OK`


### Summary :
- This Todo App is a full-stack application designed to help users manage their tasks. With a simple and easy-to-use interface, users can create, read, and delete tasks, all backed by a SQLite database that is persistent across deployments thanks to OpenShift and a Persistent Volume. The app is dockerized to run in containers, making it easy to deploy and scale in any containerized environment.
