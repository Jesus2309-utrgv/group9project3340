class TransactionsController < ApplicationController
  # Removed :show from before_action to avoid missing callback issues
  # another comment
  before_action :set_transaction, only: [:edit, :update, :destroy]

  def index
    if params[:filter].present? && params[:filter] != "All"
      @transactions = Transaction.where(transaction_type: params[:filter])
    else
      @transactions = Transaction.all
    end
  
    @transactions = @transactions.order(transaction_date: :desc)
    @total_balance = Transaction.total_balance
     end
  

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to transactions_path, notice: "Transaction was successfully recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @transaction is set using before_action :set_transaction
  end
  
  def update
    if @transaction.update(transaction_params)
      redirect_to transaction_path(@transaction), notice: "Transaction was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  # destroy
   # @transaction.destroy
   # redirect_to transactions_path, notice: "Transaction was successfully deleted."
 # end
 def destroy
  if @transaction.destroy
    redirect_to transactions_path, notice: "Transaction was successfully deleted."
  else
    redirect_to transactions_path, alert: "Transaction could not be deleted."
  end
end
def show
  @transaction = Transaction.find(params[:id])
end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :transaction_date, :category, :transaction_type, :due_date)
  end
end
