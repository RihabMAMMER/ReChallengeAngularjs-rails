@app.controller 'homeUserCtrl', ($scope,Auth,$location,$http) ->
<<<<<<< HEAD
    $scope.isLogedIn=false;

    $http.get('/GetLoggedUserInfo').then (res) ->
        console.log 'res user json', res
        if res.data.data?
            $scope.isLogedIn=true;
            $scope.user=res
        else
            $location.path '/login'
    ,(error)->
        console.log error,'Home User is not logged in'
        $location.path '/login'

    $scope.logout = ->
        Auth.logout().then (oldUser) ->
            $scope.isLogedIn=false;
            console.log oldUser," logout  !"
=======
    $scope.isLogedIn=false
    $scope.showMsgValid=false
    $scope.showMsgError=false
    $scope.user={}
    $http.get('/GetLoggedUserInfo').then (res) ->
        console.log 'res user json', res
        if res.data.data?
            $location.path '/login' if res.data.data.role is "admin"
            $scope.isLogedIn=true
            $scope.user=res
            $http.get('/conge/GetUserConges/'+$scope.user.data.data.id).then (conges) ->
                 console.log 'conges user ', conges
                 $scope.conges=conges.data.data
            ,(error)->
                console.log error,'Conges User not found'
        else
            $location.path '/login'
            return
    ,(error)->
        console.log error,' User is not logged in'
        $location.path '/login'
        return

    $scope.logout = ->
        Auth.logout().then (oldUser) ->
            $scope.isLogedIn=false
>>>>>>> KEYWORD = FIX | HOTFIX | FEATURE | REFACTOR (change code) | CHORE | ADD | REMOVE | ...
            $location.path '/login'
        ,(error) ->
            console.log error

    $scope.sendDemande = ->
        Indata = {'user_id':$scope.user.data.data.id,'date_debut':$scope.dateD,'date_fin':$scope.dateF, 'motifAb':$scope.motifAb}
        headers = {'Content-Type': 'application/json'}
        $http.post('/conge/saveConge',Indata,headers).then (response) -> 
            $scope.dateF = ''
            $scope.dateD = ''
            $scope.motifAb = ''
            $scope.showMsgValid = true
            $http.get('/conge/GetUserConges/'+$scope.user.data.data.id).then (conges) ->
                 console.log 'conges user ', conges
                 $scope.conges=conges.data.data
            ,(error)->
                console.log error,'Conges User not found'
        ,(error) ->
            console.log error, 'can not save demand !.'
            $scope.showMsgError=true

    $scope.sendModel = (id) ->
            $http.get('/conge/getUserCongeModel/'+id).then (model) ->
                 console.log 'model user ', model
                 $scope.myModel=model.data.data
            ,(error)->
                console.log error,'model User not found'

       