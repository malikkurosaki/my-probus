class V2Status {
    late String id;
    late String name;

    // a1 do not remove this line
    V2Status.open() {
        id = '1';
        name = 'open';
    }
    V2Status.reopened() {
        id = '10';
        name = 'reopened';
    }
    V2Status.accepted() {
        id = '2';
        name = 'accepted';
    }
    V2Status.rejected() {
        id = '3';
        name = 'rejected';
    }
    V2Status.approved() {
        id = '4';
        name = 'approved';
    }
    V2Status.decline() {
        id = '5';
        name = 'decline';
    }
    V2Status.progress() {
        id = '6';
        name = 'progress';
    }
    V2Status.resolved() {
        id = '7';
        name = 'resolved';
    }
    V2Status.closed() {
        id = '8';
        name = 'closed';
    }
    V2Status.pending() {
        id = '9';
        name = 'pending';
    }

    Map val() => {
        'id': id,
        'name': name,
    };

    // a1 do not remove this line
    List<V2Status> get all => [
        V2Status.open(),
        V2Status.reopened(),
        V2Status.accepted(),
        V2Status.rejected(),
        V2Status.approved(),
        V2Status.decline(),
        V2Status.progress(),
        V2Status.resolved(),
        V2Status.closed(),
        V2Status.pending(),
    ];
}